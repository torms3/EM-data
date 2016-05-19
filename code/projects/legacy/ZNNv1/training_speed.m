function [ret] = training_speed( fname, str )

    if ~exist('fname','var')
        fname = 'train';
    end

    if ~exist('str','var')
        str = [];
    end

    sInfo = [fname '.info'];
    fInfo = fopen(sInfo, 'r');
    ret.n = fread(fInfo, 1, 'uint64');

    sIter = [fname '.iter'];
    fIter = fopen(sIter, 'r');
    ret.iter = fread(fIter, ret.n, 'uint64');

    sSpd  = [fname '.speed'];
    fSpd  = fopen(sSpd, 'r');    
    ret.speed = fread(fSpd, ret.n, 'double');

    ret.str = str;

end