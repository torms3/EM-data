function [dim] = import_size( fname, ndim )

    if ~exist('ndim','var'); ndim = 3; end;

    dim = [];

    % open file
    fsz = fopen([fname '.size'], 'r');
    if fsz < 0;
        return;
    end

    % import size information
    dim = fread(fsz, ndim, 'uint32');
    dim = dim';

end