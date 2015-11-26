function [ret] = prepare_boundary_map( fname, filtrad )
%
% Prepare boundary map from ZNN outputs
%
% Usage:
%   prepare_bounddary_map( fname )
%   prepare_bounddary_map( fname, filtrad )
%
%   fname       file name of the ZNN outputs
%   filtrad     median filtering radius
%
% Return:
%   ret         boundary map preparation
%       .prob   boundary prediction
%       .mprob  median-filtered boundary prediction
%       .coord  volume coordinate
%       .size   volume size
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>  2015

    if ~exist('filtrad','var')
        filtrad = 0;
    end

    %% boundary prediction
    %
    fprintf('Preparing boundary map...\n');
    try
        ret.prob = scaledata(double(loadtiff(fname)),0,1);
    catch
        fvol = fopen(fname,'r');
        assert(fvol ~= -1);
        ret.prob = import_volume(fname);
    end

    % median filtering
    if filtrad > 0
        ret.prob  = medfilt3(ret.prob,filtrad);
    end

    % coordinate and size
    ret.coord = [1,1,1];
    ret.size  = size(ret.prob);

end