function [h] = gcolor(x,y,xd,yd,c)
% function [h] = gcolor(x,y,xd,yd,c)
%
% special replacement for pcolor
%
% input  :	x	x-vector (center of faces)
%		y	y-vector (center of faces)
%		xd	vector of width of faces
%		yd	vector of height of faces
%		c	pseudo color matrix
%
% output :	h	handle to object
%
% version 0.1	last change 30.6.2006

% G.Krahmann, IFM-GEOMAR, June 2006

% check input arguments
if nargin~=5
  if nargin==3
    if is_octave && graphics_toolkit == 'gnuplot'
      % pcolor uses splot with binary matrix inline data. gnuplot 5.4+
      % cannot reliably terminate binary matrix streams inside multiplot
      % (used by subplot), producing garbled output.
      % imagesc uses plot with a binary array of known byte count, so
      % gnuplot terminates it correctly. It is also a single command
      % (fast), unlike patch which creates one object per data point.
      h = imagesc(x, y, xd);
      axis xy;
    else
      h=pcolor(x,y,xd);
      set(h, 'EdgeColor', 'none');
    end
    return;
  else
    error('wrong number of arguments')
  end
end

x = x(:);
y = y(:);
xd = xd(:);
yd = yd(:);

% calculate new x and y-vectors
xn = reshape([x-xd/2, x+xd/2, x+xd/1.5]', [], 1);
yn = reshape([y-yd/2, y+yd/2, y+yd/1.5]', [], 1);

% prepare new matrix
cn = repmat(nan,size(c)*3);
cn(1:3:end,1:3:end) = c;
cn(2:3:end,1:3:end) = c;
cn(1:3:end,2:3:end) = c;
cn(2:3:end,2:3:end) = c;

% display matrix
h = pcolor(xn,yn,cn);
% in some versions of matlab greater than 7.2 the plots can't
% be seen because the edgle lines blot them out.
% the following line removes the edgelines.
set(h, 'EdgeColor', 'none'); % Pedro Pena Thomas Sevilla 9.12.16
