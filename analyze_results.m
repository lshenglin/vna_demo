% fname = 'Sparameter_2017_07_07_11_41_35.csv';

vnaCfg = struct('Nrx', 2, 'startFreq', 6.25e9, 'stopFreq', 6.75e9);
% vnaCfg = struct('Nrx', 2, 'startFreq', 3e9, 'stopFreq', 8e9);
pkCfg = struct('relThresh', 0.3, 'Npk', 3);

% fname = '/Users/psflab/Documents/R1/Sparameter_2017_08_11_11_45_11.csv';
fname = '/Users/psflab/Documents/R1/Sparameter_2017_08_11_14_05_31.csv';

Nup = 20;
Npath = 1;

valid_range = 132:240;

mockup_ant_geometry_cfg = struct('d12', 26*1e-3, ...
	'd23', 0, 'd13', 0, 'c', 299792458);
extVNAdata_cal(fname, vnaCfg, mockup_ant_geometry_cfg, pkCfg, Nup, Npath, 'csv', 0, valid_range);
