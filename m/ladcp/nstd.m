function y = nstd(x,flag,dim)
%NSTD   Standard deviation, ignoring NaN.
%   Same as STD, but NaN's are ignored.
%

%   Copyright (c) 1997 by Toby Driscoll.
%   Adapted from STD.M, written by The MathWorks, Inc.
%   added backward compatibility	G.Krahmann, LODYC Paris

  if nargin<2, flag = 0; end
  if nargin<3, 
    dim = min(find(size(x)~=1));
    if isempty(dim), dim = 1; end
  end

% Avoid divide by zero.
  if size(x,dim)==1, y = zeros(size(x)); return, end

  tile = ones(1,max(ndims(x),dim));
  tile(dim) = size(x,dim);

  xc = x - repmat(nmean(x,dim),tile);  % Remove mean
  mask = isnan(xc);
  xc(mask) = 0;
  s = sum(~mask,dim);
  s(s==0) = NaN;
  if flag,
    y = sqrt(sum(conj(xc).*xc,dim)./s);
  else
    z = (s==1);
    s(z) = Inf; 
    y = sqrt(sum(conj(xc).*xc,dim)./(s-1));
  end
