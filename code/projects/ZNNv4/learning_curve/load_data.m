function data = load_data( fname, phase, keys )

    assert(strcmp(phase,'train')||strcmp(phase,'test'));

    len = [];
    for i = 1:numel(keys)
        key = keys{i};
        val = hdf5read(fname,['/' phase '/' key]);
        data.(key) = val(:);
        len(i) = numel(val);
    end

    n = min(len);
    fields = fieldnames(data);
    for i = 1:numel(fields)
        data.(fields{i})(1:end-n) = [];
    end

end
