function softmax_affinity_script( prefix, samples, replace_tif )

    if ~exist('replace_tif','var'); replace_tif = false; end;

    for i = 1:numel(samples)

        sample = samples(i);

        % construct file name
        fname  = [prefix '_sample' num2str(sample) '_output'];

        % apply softmax to get affinity
        [affs] = softmax_affinity(prefix,sample);
        [affs] = flip(affs,4);

        % export affinity graph binary
        export_tensor(fname,affs,'affin','single');

        % exprot hdf5
        hdf5write([fname '.h5'],'/main',affs);

        if replace_tif
            delete([fname '*.tif']);
            saveastiff(single(affs(:,:,:,3)),[fname '_0.tif']); % z-affinity
            saveastiff(single(affs(:,:,:,2)),[fname '_1.tif']); % y-affinity
            saveastiff(single(affs(:,:,:,1)),[fname '_2.tif']); % x-affinity
        end

    end

end