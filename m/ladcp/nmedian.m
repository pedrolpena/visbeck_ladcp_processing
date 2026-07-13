function y = nmedian(x,dim)
%NMEDIAN Median value, ignoring NaN.
%   Same as MEDIAN, but NaN's are ignored.
%

%   Copyright (c) 1997 by Toby Driscoll.
%   Adapted from MEDIAN.M, written by The MathWorks, Inc.
%   added backward compatibility	G.Krahmann, LODYC Paris

if nargin==1, 
  dim = min(find(size(x)~=1)); 
  if isempty(dim), dim = 1; end
end
if isempty(x), y = []; return, end


  siz = [size(x) ones(1,max(0,dim-ndims(x)))];
  n = size(x,dim);

% Permute and reshape so that DIM becomes the row dimension of a 2-D array
  perm = [dim:max(length(size(x)),dim) 1:dim-1];
  x = reshape(permute(x,perm),n,prod(siz)/n);

% Sort along first dimension
  x = sort(x,1);

  n    = sum(~isnan(x));
  y    = NaN(1, size(x,2));
  nrows = size(x, 1);
  has  = n > 0;
  if any(has)
    cols = find(has);
    nc   = n(cols);
    lo   = (cols - 1) * nrows + floor((nc + 1) / 2);
    hi   = (cols - 1) * nrows + floor((nc + 2) / 2);
    y(cols) = (x(lo) + x(hi)) * 0.5;
  end
  
% Permute and reshape back
  siz(dim) = 1;
  y = ipermute(reshape(y,siz(perm)),perm);

