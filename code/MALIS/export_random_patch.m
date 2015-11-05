function [x,y] = export_random_patch( bmap, lbl, psz, opath )

    % image size
    sz = size(bmap,1)

    % random location
    x = randi(sz-psz+1);
    y = randi(sz-psz+1);

    % extract patch
    patch.bmap = bmap(x:x+psz-1,y:y+psz-1);
    patch.lbl  = lbl(x:x+psz-1,y:y+psz-1);

    % export patch
    current = pwd;
    cd(opath);

        subdir = sprintf('patch_%dx%d/',psz,psz);
        if ~exist(subdir,'dir')
            mkdir(subdir);
        end

        fname = [subdir sprintf('x%d_y%d_bmap.bin',x,y)];
        export_volume(fname,patch.bmap);

        fname = [subdir sprintf('x%d_y%d_lbl.bin',x,y)];
        export_volume(fname,patch.lbl);

    cd(current);

end