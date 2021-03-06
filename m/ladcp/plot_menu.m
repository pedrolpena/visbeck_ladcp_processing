function plot_menu(figExt,files)
% initialize the plot menu for LADCP processing
%
% version 0.4	last change 16.11.2012

% G.Krahmann, IFM-GEOMAR, 2004

% changed location of windows for OSX     GK, 15.07.2008  0.2-->0.3
% use sfigure instead of figure           GK, 16.11.2012  0.3-->0.4
% modified for octave  Pedro Pena


% if is_octave < 1
%     figExt ='fig';
% else
%     figExt ='ofig';
% end
figExt='png';
%dd = dir(['tmp',filesep,'*.',figExt]);

%for n=1:length(dd)
%  delete(['tmp',filesep,dd(n).name])
%end
global mh

% handle newer matlab versions
% if version('-release')>=14
if get_matlab_version > 8.04 % Pedro Pena 9.12.16
    imac = 0;
else
    imac = ismac;
end

% create 2 windows
% one for the control menu and one for the actual plots
sfigure(1);
pause(0.5);
clf
set(gcf,'position',[10,10+imac*100,170,800],'numbertitle','off','menubar',...
	'none','name','LADCP 1');



sfigure(2);
pause(0.5);
clf
pos = get(gcf,'pos');
set(gcf,'position',pos,'numbertitle','off',...
	'name','LADCP 2');
%set(gcf,'Units','inches','Color', 'white');

% create the menu
sfigure(1);
if is_octave <1
fh(1) = uicontrol('style','frame','position',[10,10,150,600]);
fh(2) = uicontrol('style','frame','position',[10,620,150,120]);
end
th(1) = uicontrol('style','text','position',[15,705,140,30],...
	'horizontalalignment','center','string','LADCP',...
	'fontsize',14);

th(2) = uicontrol('style','text','position',[15,665,140,30],...
	'horizontalalignment','center','string','processing',...
	'fontsize',14);	
th(3) = uicontrol('style','text','position',[15,625,140,30],...
	'horizontalalignment','center','string','display',...
	'fontsize',14);	
	
mh(1) = uicontrol('style','push','position',[15,585,140,20],...
	'horizontalalignment','center','string','UV-profiles',...
	'callback',['plot_controls(1,''',figExt,''',''',files,''')']);
mh(2) = uicontrol('style','push','position',[15,560,140,20],...
	'horizontalalignment','center','string','W,Z,sensors',...
	'callback',['plot_controls(2,''',figExt,''',''',files,''')']);
mh(3) = uicontrol('style','push','position',[15,535,140,20],...
	'horizontalalignment','center','string','ERR-profiles',...
	'callback',['plot_controls(3,''',figExt,''',''',files,''')']);
mh(4) = uicontrol('style','push','position',[15,510,140,20],...
	'horizontalalignment','center','string','SURF/BOT recog.',...
	'callback',['plot_controls(4,''',figExt,''',''',files,''')']);
mh(5) = uicontrol('style','push','position',[15,485,140,20],...
	'horizontalalignment','center','string','Heading dual',...
	'callback',['plot_controls(5,''',figExt,''',''',files,''')']);
mh(6) = uicontrol('style','push','position',[15,460,140,20],...
	'horizontalalignment','center','string','HDG/PIT/ROL',...
	'callback',['plot_controls(6,''',figExt,''',''',files,''')']);
mh(7) = uicontrol('style','push','position',[15,435,140,20],...
	'horizontalalignment','center','string','CTD motion',...
	'callback',['plot_controls(7,''',figExt,''',''',files,''')']);
mh(8) = uicontrol('style','push','position',[15,410,140,20],...
	'horizontalalignment','center','string','CTD-LADCP merging',...
	'callback',['plot_controls(8,''',figExt,''',''',files,''')']);
mh(9) = uicontrol('style','push','position',[15,385,140,20],...
	'horizontalalignment','center','string','SADCP',...
	'callback',['plot_controls(9,''',figExt,''',''',files,''')']);
mh(10) = uicontrol('style','push','position',[15,360,140,20],...
	'horizontalalignment','center','string','Vel offset',...
	'callback',['plot_controls(10,''',figExt,''',''',files,''')']);
mh(11) = uicontrol('style','push','position',[15,335,140,20],...
	'horizontalalignment','center','string','Warnings',...
	'callback',['plot_controls(11,''',figExt,''',''',files,''')']);
mh(12) = uicontrol('style','push','position',[15,310,140,20],...
	'horizontalalignment','center','string','Inv. Weights',...
	'callback',['plot_controls(12,''',figExt,''',''',files,''')']);
mh(13) = uicontrol('style','push','position',[15,285,140,20],...
	'horizontalalignment','center','string','Bottom Track',...
	'callback',['plot_controls(13,''',figExt,''',''',files,''')']);
mh(14) = uicontrol('style','push','position',[15,260,140,20],...
	'horizontalalignment','center','string','TargetStr Edited',...
	'callback',['plot_controls(14,''',figExt,''',''',files,''')']);
mh(15) = uicontrol('style','push','position',[15,235,140,20],...
	'horizontalalignment','center','string','Correl. Edited',...
	'callback',['plot_controls(15,''',figExt,''',''',files,''')']);
mh(16) = uicontrol('style','push','position',[15,210,140,20],...
	'horizontalalignment','center','string','Inv. Weights 2',...
	'callback',['plot_controls(16,''',figExt,''',''',files,''')']);
	
