function data = load_data( fname, phase )

    assert(strcmp(phase,'train')||strcmp(phase,'test'));

    data.iter = hdf5read(fname,['/' phase '/it']);  % iterations
    data.err  = hdf5read(fname,['/' phase '/err']); % cost
    data.cls  = hdf5read(fname,['/' phase '/cls']); % classification error

end