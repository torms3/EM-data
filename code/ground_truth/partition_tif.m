function partition_tif( fname, shape )

    ext = findstr(fname,'.tif');
    assert(~isempty(ext));

    disp(['   Loading [' fname ']...']);
    vol = loadtiff(fname);
    C = partition_volume(vol,shape);

    for i = 1:numel(C)
        subvol = C{i};
        subname = [fname(1:ext-1) '-' num2str(i) '.tif'];
        disp(['Processing [' subname ']...']);
        saveastiff(subvol,subname);
    end

end