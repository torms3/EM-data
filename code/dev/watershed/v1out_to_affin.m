function v1out_to_affin( fname, newname )

    % e.g. fname    = 'out103'
    %      newname  = 'Piriform_sample9_output'
    aff{1} = import_volume([fname '.0'],[],[],'double');
    aff{2} = import_volume([fname '.1'],[],[],'double');
    aff{3} = import_volume([fname '.2'],[],[],'double');

    aff = single(cat(4,aff{:}));

    % export affinity graph binary
    export_tensor(newname,aff,'affin','single');

    % exprot hdf5
    % hdf5write([fname '.h5'],'/main',aff);

end