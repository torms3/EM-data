function [ret] = crop_result( result, offset, sz )
% 
% Crop boundary map or affinity graph results
% 
% Usage:
%   crop_result( result, offset, sz )
%   
%   result      boundary map or 3D affinity graph
%   offset      crop offset
%   sz          crop size
%
% Return:
%   ret         cropped result
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>  2015

    names = fieldnames(result);
    for i = 1:numel(names)
        if strcmp(names{i},'coord');continue;end;
        if strcmp(names{i},'size');continue;end;
        result.(names{i}) = crop_volume(result.(names{i}),offset,sz);
    end

    result.coord = result.coord + offset - [1,1,1];
    result.size  = sz;

    ret = result;

end