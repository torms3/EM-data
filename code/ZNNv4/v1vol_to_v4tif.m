function v1vol_to_v4tif( fname )

    vol = import_volume(fname);
    saveastiff(single(vol),[fname '.tif']);

end