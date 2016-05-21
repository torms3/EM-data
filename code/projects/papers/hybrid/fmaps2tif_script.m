function fmaps2tif_script( crop, fpath )

    if ~iscell(crop);       crop = {crop};end;
    if ~exist('fpath','var'); fpath = pwd;end;
    cd(fpath);

    list = dir('out*');
    for i = 1:numel(list)

        fname = list(i).name;
        if any(findstr(fname,'size'))
            continue;
        end

        idx = findstr(fname,'.');
        num = str2num(fname(idx-1));
        
        fmaps2tif(fname,crop{num},[],1);

    end

end