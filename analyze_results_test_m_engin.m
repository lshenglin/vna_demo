function [angle, range,phase1,phase2,MY_PHI] = analyze_results_test_m_engin(fliename)
%fname = 'Sparameter_2017_07_07_11_41_35.csv';

vnaCfg = struct('Nrx', 3, 'startFreq', 6.25e9, 'stopFreq', 6.75e9);
% vnaCfg = struct('Nrx', 3, 'startFreq', 3e9, 'stopFreq', 8e9);
pkCfg = struct('relThresh', 0.3, 'Npk', 3);

fname = fliename;
Nup = 20;
Npath = 1;

valid_range = 130:242;

mockup_ant_geometry_cfg = struct('d12', 26*1e-3, ...
	'd23', 0, 'd13', 0, 'c', 299792458);
[angle, range,phase1,phase2,MY_PHI] = extVNAdata(fname, vnaCfg, mockup_ant_geometry_cfg, pkCfg, Nup, Npath, 'csv', 0, valid_range);
end