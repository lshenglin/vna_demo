% fname = 'Sparameter_2017_07_07_11_41_35.csv';

vnaCfg = struct('Nrx', 3, 'startFreq', 6.25e9, 'stopFreq', 6.75e9);
% vnaCfg = struct('Nrx', 2, 'startFreq', 3e9, 'stopFreq', 8e9);
pkCfg = struct('relThresh', 0.3, 'Npk', 3);

% fname ='/Users/shenglinli/Documents/R1sweep_data/20170613/new_phone_5GHzBW_10MHzstep_2degrees/Sparameter_2017_06_13_09_50_44.csv';

% fname = '/Users/shenglinli/Documents/R1sweep_data/20170613/new_phone_5GHzBW_10MHzstep_2degrees/Sparameter_2017_06_13_11_38_54.csv';
% fname = '/Users/shenglinli/Documents/R1sweep_data/20170614/new_phone_5GHzBW_10MHzstep_2degrees/Sparameter_2017_06_14_10_41_00.csv';
% fname = '/Users/shenglinli/Documents/R1sweep_data/20170615/new_phone_5GHzBW_10MHzstep_2degrees/Sparameter_2017_06_15_09_17_31.csv';
% fname = '/Users/shenglinli/Documents/R1sweep_data/20170705/new_phone_5GHzBW_10MHzstep_2degrees/Sparameter_2017_07_05_17_45_44.csv';
% fname = '/Users/shenglinli/Documents/R1sweep_data/20170706/new_phone_5GHzBW_10MHzstep_2degrees/Sparameter_2017_07_06_15_36_24.csv';
% fname = '/Users/shenglinli/Documents/R1sweep_data/20170707/new_phone_5GHzBW_10MHzstep_2degrees/Sparameter_2017_07_07_11_41_35.csv';

% fname = '/Users/shenglinli/Documents/R1sweep_data/20170710/new_phone_500MHzBW_10MHzstep_2degrees/Sparameter_2017_07_10_12_09_37.csv';

% fname = '/Users/shenglinli/Documents/R1sweep_data/20170712/new_phone_500MHzBW_10MHzstep_2degrees/Sparameter_2017_07_12_11_24_33.csv';
% fname = '/Users/shenglinli/Documents/R1sweep_data/20170712/new_phone_5GHzBW_10MHzstep_2degrees/Sparameter_2017_07_12_14_40_23.csv';
% fname = '/Users/shenglinli/Documents/R1/Sparameter_2017_08_08_09_11_00.csv';
fname = '/Users/shenglinli/Documents/R1/Sparameter_2017_08_08_09_52_05.csv';

Nup = 20;
Npath = 1;

valid_range = 118:236;

mockup_ant_geometry_cfg = struct('d12', 26*1e-3, ...
	'd23', 0, 'd13', 0, 'c', 299792458);
extVNAdata_cal(fname, vnaCfg, mockup_ant_geometry_cfg, pkCfg, Nup, Npath, 'csv', 0, valid_range);
