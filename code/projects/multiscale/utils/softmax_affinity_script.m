function softmax_affinity_script( prefix, samples, replace_tif )

    if ~exist('replace_tif','var'); replace_tif = false; end;

    for i = 1:numel(samples)

        sample = samples(i);

        % construct file name
        fname  = [prefix '_sample' num2str(sample)];
        oname  = [fname '_output'];

        % apply softmax to get affinity
        [affs] = softmax_affinity(prefix,sample);
        [affs] = flip(affs,4);

        % export affinity graph binary
        export_tensor(oname,affs,'affin','single');

        % exprot hdf5
        hdf5write([oname '.h5'],'/main',affs);

        if replace_tif
            delete([oname '*.tif']);
        else
            for i = 1:6
                src = [oname '_' num2str(i-1) '.tif'];
                dst = [fname '_score_' num2str(i-1) '.tif'];
                movefile(src,dst);
            end
        end

        saveastiff(single(affs(:,:,:,3)),[oname '_0.tif']); % z-affinity
        saveastiff(single(affs(:,:,:,2)),[oname '_1.tif']); % y-affinity
        saveastiff(single(affs(:,:,:,1)),[oname '_2.tif']); % x-affinity

    end

end