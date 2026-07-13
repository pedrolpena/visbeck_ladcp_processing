% run_process_cast.m
args = argv();
if length(args) < 1
  error('Usage: octave run_process_cast.m <stn> [ctd_lag]');
end

addpath(pwd());

if length(args) == 1
  process_cast(args{1});
elseif length(args) == 2
  process_cast(args{1}, args{2});
else
  process_cast(args{1}, args{2}, args{3});
end
