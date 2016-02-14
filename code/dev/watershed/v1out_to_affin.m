function v1out_to_affin( fname, oname )

    if ~iscell(fname); fname = {fname}; end;
    if ~iscell(oname); oname = {oname}; end;
    assert(numel(fname)==numel(oname));

    for i = 1:numel(fname)

        % e.g. fname = 'out103'
        %      oname = 'Piriform_sample9_output'
        aff{1} = import_volume([fname{i} '.0'],[],[],'double');
        aff{2} = import_volume([fname{i} '.1'],[],[],'double');
        aff{3} = import_volume([fname{i} '.2'],[],[],'double');
        affin  = single(cat(4,aff{:}));

        % export affinity graph binary
        export_tensor(oname{i},affin,'affin','single');

        % exprot hdf5
        % hdf5write([oname{i} '.h5'],'/main',aff);

    end

end