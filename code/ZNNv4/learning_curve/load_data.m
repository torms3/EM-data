function data = load_data( fname, phase, errtype )

    if ~exist('errtype','var'); errtype = 'err'; end;

    assert(strcmp(phase,'train')||strcmp(phase,'test'));

    data.iter = hdf5read(fname,['/' phase '/it']);       % iterations
    data.cls  = hdf5read(fname,['/' phase '/cls']);      % classification error
    data.err  = hdf5read(fname,['/' phase '/' errtype]); % cost

    n = numel(data.err);
    data.iter(1:end-n) = [];
    data.cls(1:end-n)  = [];

end