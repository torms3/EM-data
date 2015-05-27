function vol2tif_script( key )

    list = dir(key);
    for i = 1:numel(list)
        fname = list(i).name;
        if any(findstr(fname,'.size'))
            continue;
        end
        vol2tif(fname);
    end

end