function [seg] = import_segmentation( fname, dim, ext )
% 
% Import 3D volume from file
% 
% Usage:
%   import_segmentation( fname )
%   import_segmentation( fname, [x y z] )
%   import_segmentation( fname, [], ext )
%   import_segmentation( fname, [x y z], ext )
%   
%   fname:  file name
%   dim:    3D volume dimension
%           if not exists, read information from [fname.size]
%   ext:    if exists, file name becomes [fname.ext]
%
% Return:
%   seg     3D volume
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>, 2014
    
    if ~exist('dim','var')
        dim = [];
    end

    % volume dimension
    if isempty(dim)
        fsz = fopen([fname '.size'], 'r');
        if fsz < 0
            seg = [];
            return;
        end
        x = fread(fsz, 1, 'uint32');
        y = fread(fsz, 1, 'uint32');
        z = fread(fsz, 1, 'uint32');
        dim = [x y z];
    end
    assert(numel(dim) == 3);
    fprintf('dim = [%d %d %d]\n',dim(1),dim(2),dim(3));
    
    % volume
    if exist('ext','var')       
        fvol = fopen([fname '.' ext], 'r');
    else
        fvol = fopen(fname, 'r');
    end 
    if fvol < 0
        seg = [];
        return;
    end
    
    seg = zeros(prod(dim), 1);
    seg = fread(fvol, size(seg), 'uint32');
    seg = uint32(reshape(seg, dim));

end