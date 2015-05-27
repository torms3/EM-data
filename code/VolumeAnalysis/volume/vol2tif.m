function vol2tif( fname, dim )

    if ~exist('dim','var')
        dim = [];
    end

    vol = import_volume(fname,dim);
    write_tif_image_stack(vol,[fname '.tif']);

end