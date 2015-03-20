function training_speed( fname )

    if ~exist('fname','var')
        fname = 'train';
    end

    sInfo = [fname '.info'];
    fInfo = fopen(sInfo, 'r');
    ret.n = fread(fInfo, 1, 'uint64');

    sIter = [fname '.iter'];
    fIter = fopen(sIter, 'r');
    ret.i = fread(fIter, ret.n, 'uint64');

    sSpd  = [fname '.speed'];
    fSpd  = fopen(sSpd, 'r');    
    ret.s = fread(fSpd, ret.n, 'double');
    
    figure;
    plot(ret.i,ret.s);

end