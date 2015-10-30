function v4tif_to_v1vol( fname, ext )

    % extension
    idx = findstr(fname,'.');
    if any(idx)
        pos  = idx(end);
        pre  = fname(1:pos-1);
        post = fname(pos:end);
    else
        pre  = fname;
        post = '.tif';
    end

    vol = loadtiff([pre post]);
    if exist('ext','var')
        export_volume(pre,vol,ext);
    else
        export_volume(pre,vol);
    end

end