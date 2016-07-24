function v4out_to_affin( prefix, sample )

    % e.g. fname = 'Piriform_sample1_output'
    fname = [prefix '_sample' num2str(sample) '_output'];

    try
        aff = tif_to_affin;
    catch
        disp([fname ': No such file']);
        return;
    end

    % export affinity graph binary
    export_tensor(fname,aff,'affin','single');

    % exprot hdf5
    hdf5write([fname '.h5'],'/main',aff);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function aff = h5_to_affin()

        aff = hdf5read([fname '.h5'],'/main');
        aff = permute(aff,[2 1 3 4]);
        aff = flipdim(aff,4);

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function aff = tif_to_affin()

        % aff{1} = loadtiff([fname '_2.tif']); % x-affinity
        % aff{2} = loadtiff([fname '_1.tif']); % y-affinity
        % aff{3} = loadtiff([fname '_0.tif']); % z-affinity

        aff{1} = loadtiff([fname '_1.tif']); % x-affinity
        aff{2} = loadtiff([fname '_2.tif']); % y-affinity
        aff{3} = loadtiff([fname '_0.tif']); % z-affinity

        aff = cat(4,aff{:});

    end

end