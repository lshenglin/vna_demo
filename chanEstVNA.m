function [hEst_t, hEst_f, delay, PDP, ang, fs] = chanEstVNA(fname, pkCfg, Nup, mode, ang_val)

if nargin == 3
  mode = 'csv';
  ang_val = 0;
end
  
relThresh = pkCfg.relThresh;
Npk = pkCfg.Npk;

% read the frequency domain channel estimate in
if strcmpi(mode, 'csv')
  M = csvread(fname, 1, 0);
  angle_candidate = M(:, 1);
  ang = unique(angle_candidate);
else
  % matlab mode, single angle
  M = load(fname);
  ang = ang_val;
  M = [ang_val * ones(size(M, 1), 1) M];
  angle_candidate = M(:, 1);
end
Nrx = 2;

cnt = 1;
% loop over each angle and construct time domain response
for a = ang.'
  idx = find(angle_candidate == a);
  raw_data = M(idx, 2:end);
  
  % extract frequency range
  freq_Range = raw_data(:, 1);
  
  % extract frequency response between 3GHz to 8GHz
  hrx_f(:, 1) = raw_data(:, 2) + j*raw_data(:, 3);
  hrx_f(:, 2) = raw_data(:, 4) + j*raw_data(:, 5);
%   hrx_f(:, 3) = raw_data(:, 6) + j*raw_data(:, 7);
  
  % Mask the frequency domain response to be capturing the center 500MHz BW
  if 0
    center = 2501;
%     center = 252;
    exclude_left = center-251;
    exclude_right = center+251;
    hrx_f(1:exclude_left, :) = 0;
    hrx_f(exclude_right:end, :) = 0;
  end
  
  hEst_f(cnt, :, :) = hrx_f;
  
  hrx_t = ifft(fftshift(hrx_f, 1));
  hrx_t = resample(hrx_t, Nup, 1);
  hEst_t(cnt, :, :) = hrx_t;
  
  % extract peaks for each angle and antennas
  for lp = 1 : Nrx
    [pk_loc_picked_time_sorted, pk_val_picked_time_sorted, h_path] = pkExtract(hrx_t(:, lp), relThresh, Npk);
    
    delay(cnt, 1:length(pk_loc_picked_time_sorted), lp) = pk_loc_picked_time_sorted;
    PDP(cnt, 1:length(pk_loc_picked_time_sorted), lp) = h_path;
  end
  cnt = cnt + 1;
end

fs = (freq_Range(end) - freq_Range(1)) * Nup;
