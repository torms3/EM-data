function mask_segmentation( fname, oname )

    fprintf('Reading %s...\n',fname);
    tic;seg = hdf5read(fname,'/main');toc
    seginfo = parse_segments;
    fprintf('Creating valid mask...\n');
    tic;msk = create_valid_mask(seg,seginfo);toc
    seg(~msk) = 0;
    fprintf('Saving %s...\n',oname);
    tic;hdf5write(oname,'/main',uint32(seg));toc

end
