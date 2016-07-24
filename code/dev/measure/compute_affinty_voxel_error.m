function ret = compute_affinty_voxel_error( fname, label )

    validate_args;

    for i = 1:numel(fname)
        ret{i} = do_compute(fname{i},label{i});
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function ret = do_compute( fname, label )

        disp([fname ' is being processed...']);

        % ConvNet output affinity graph
        try
            affin.z = loadtiff([fname '_0.tif']);
            affin.y = loadtiff([fname '_1.tif']);
            affin.x = loadtiff([fname '_2.tif']);
        catch
            try
                aff = import_tensor(fname,[],'affin','single');
            catch
                try
                    aff = hdf5read([fname '.h5'],'/main');
                catch
                    assert(0);
                end
            end
            affin.x = aff(:,:,:,1);
            affin.y = aff(:,:,:,2);
            affin.z = aff(:,:,:,3);
        end

        % ground truth affinity graph
        truth = generate_affinity_graph(label);

        % compare volumes
        img.x = crop_volume(affin.x,[2 2 2]);
        img.y = crop_volume(affin.y,[2 2 2]);
        img.z = crop_volume(affin.z,[2 2 2]);

        ret.x = optimize_voxel_error(img.x, truth.x);
        ret.y = optimize_voxel_error(img.y, truth.y);
        ret.z = optimize_voxel_error(img.z, truth.z);

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function validate_args

        if ~iscell(fname); fname = {fname};end;
        if ~iscell(label); label = {label};end;
        assert(numel(fname)==numel(label));

    end

end