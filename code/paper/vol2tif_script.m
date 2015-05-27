function vol2tif_script( key )

    list = dir(key);
    for i = 1:numel(list)
        vol2tif(list(i).name);
    end

end