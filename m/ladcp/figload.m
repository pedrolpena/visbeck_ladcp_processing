function [] = figload(file,fig);
% function [] = figload(file,[fig]);
%
% loads a matlab fig file saved with hgsave
% this is a replacement for hgload
% hgload always opens a new figure to display the loaded figure
% figload displays in the currently open figure or in
% the figure with the handle fig
% figload is less versatile in that it can only handle a single figure
%
% input  :  file        - filename with a figure stored in it
%           fig	[gcf]   - optional figure handle
%
% version 0.6	 last change 16.11.2012

% G.Krahmann, LDEO Oct 2004

% added no displayable output                GK  08.02.2006  0.1- >0.2
% changed exist commands                     GK	 12.09.2007  0.2-->0.3
% work-around for newer Matlab versions      GK  15.07.2008  0.3-->0.4
% adapted to higher version numbers          GK, 31.05.2011  0.4-->0.5
% use sfigure instead of figure              GK, 16.11.2012  0.5-->0.6

% parse arguments
if nargin<2
    fig = gcf;
end

%f=textscan(file,'%s','delimiter','.')
%figName=[f{1}{1},'.pdf'];
%eval(['print -dpdf ', figName]);
% load the figure
% the following structure name is hardwired for matlab version 6.1
% it could possibly change. Load a new fig file and add the
% the new structure name.
if exist(file,'file')
    
    
    %
    % check whether we are running a version of Matlab newer than
    % 7.2.
    % I am not sure whether the following code works under older versions
    % fixed version check bug. the version check is treating the decimal part
    % as a major revision. eg. 7.2-7.9 would pass but 8.0-8.2 would
    % fail even though this version is greater. the two strings need to be
    % concatentated and converted to a number to compare. Matlab 2016a failed
    % because it's version 9.0.0.341360.
    % fixed and tested with matlab 2016a going to place this code into a
    % function called get_matlab_version
    % Pedro Pena 9.9.2016
    
    
    
    %   vv = version;
    %   ind = findstr(vv,'.');
    %   v1 = str2num(vv(1:ind(1)-1));
    %   v2 = str2num(vv(ind(1)+1:ind(2)-1));
    %   v3= str2num([num2str(v1),'.',num2str(v2)]);
    %   if v1>=7 & v2>3
    
    
    if get_matlab_version >= 7.03
        if is_octave < 1
            sfigure(2);
            clf
            % some code 'taken' from importfig.m at mathworks user site
            ImportFig=hgload(file,struct('visible','off'));
            ImportFigAxes=get(ImportFig,'Children');
            cmap = get(ImportFig,'Colormap');
            NewSubplotAxes=copyobj(ImportFigAxes,2);
            set(2,'colormap',cmap);
            delete(ImportFig);
            
            return
        else
            sfigure(2);
            clf
            hgload(file);%added for octave Pedro Pena
            return
        end
    end
    
    if is_octave < 1
        eval(['load ',file,' -mat']);
    else
        load(file)
    end
    
    if exist('hgS_050200','var')
        s = hgS_050200;
    elseif exist('hgS_070000','var')
        s = hgS_070000;
    elseif exist('s_oct40','var')
        s = s_oct40;
    else
        error('Edit figload.m .')
    end
else
    %  warning(['File ',file,' does not exist.']);
    clf
    text(0,0.25,['Figure ',strtok(file(17:end),'.')],'horizontalalignment','center',...
        'fontweight','bold','fontsize',30)
    text(0,0,'No displayable output','horizontalalignment','center',...
        'fontweight','bold','fontsize',30)
    axis([-1,1,-1,1])
    set(gca,'visible','off')
    return
end

if prod(size(s))==1
    if strcmp(s.type,'figure')
        if gcf~=fig
            sfigure(fig);
        end
        clf
        if is_octave < 1
        
            s.properties = rmfield(s.properties,'ApplicationData');
            set(gcf,s.properties)
        
        end
        
        warnState = warning('off', 'all');
        for n=1:length(s.children)
            if is_octave < 1
                struct2handle(s.children(n),gcf);
            else
                 struct2hdl(s.children(n),gcf);
            end
        end
        warning(warnState);
        ch = get(gcf,'children');	% handle disappearing streamer
        for n=1:length(ch)
            if strcmp(get(ch(n),'tag'),'Streamer')
                ch2 = get(ch(n),'Title');
                set(ch2,'visible','on');
            end
        end
    end
end
