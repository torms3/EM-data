function vol2tif_script( key, crop )

    list = dir(key);
    for i = 1:numel(list)
        fname = list(i).name;
        if any(findstr(fname,'.size'))
            continue;
        end
        if any(findstr(fname,'.tif'))
            continue;
        end
        vol2tif(fname,[],crop);
    end

end