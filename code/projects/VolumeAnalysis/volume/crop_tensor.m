function [tensor] = crop_tensor( tensor, offset, sz )
% 
% Crop 4D tensor
% 
% Usage:
%   crop_tensor( tensor, offset )
%   crop_tensor( tensor, offset, sz )
%   
%   tensor    4D tensor
%   offset    crop offset
%   sz        crop size
%
% Return:
%   tensor    cropped tensor
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>  2015

    if ~exist('sz','var')
        sz = [];
    end

    ox = offset(1);
    oy = offset(2);
    oz = offset(3);

    if isempty(sz)
        tensor = tensor(ox:end, oy:end, oz:end, :);
    else
        tensor = tensor(ox:ox+sz(1)-1, oy:oy+sz(2)-1, oz:oz+sz(3)-1, :);
    end

end