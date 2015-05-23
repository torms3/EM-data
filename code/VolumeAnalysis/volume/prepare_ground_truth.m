function [truth] = prepare_ground_truth( label, result, mask )
% 
% Prepare ground truth
% 
% Usage:
%   prepare_ground_truth( label, result, mask )
%   
%   label       ground truth segmentation
%   result      boundary map
%
% Return:
%   truth       ground truth
%       .mask   label mask
%       .coord  coordinate
%       .size   size
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>  2015

    %% ground truth
    % 
    fprintf('Preparing ground truth...\n');

    % crop
    offset  = result.coord;
    sz      = result.size;

    truth.label = crop_volume(label,offset,sz);
    truth.mask  = crop_volume(mask,offset,sz);
    
    truth.coord = offset;
    truth.size  = sz;

end