function vol2tif( fname, dim, crop )

    if ~exist('dim','var');   dim = [];end;
    if ~exist('crop','var'); crop = [];end;

    disp(['vol2tif: ' fname]);
    vol = import_volume(fname,dim);

    if any(crop)
        [X,Y,Z] = size(vol);
        offset  = floor(([X Y Z] - crop)/2) + [1 1 1];
        sz      = crop;
        vol     = crop_volume(vol,offset,sz);
    end

    write_tif_image_stack(vol,[fname '.tif']);

end