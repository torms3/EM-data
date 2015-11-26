function [x,y] = export_random_patch( bmap, lbl, psz, opath, z )

    % image size
    sz = size(bmap,1);

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

        [xaff,yaff] = make_affinity(patch.bmap,false);
        fname = [subdir sprintf('x%d_y%d_z%d_',x,y,z)];
        export_volume([fname 'xaff.bin'],xaff);
        export_volume([fname 'yaff.bin'],yaff);
        export_volume([fname 'zaff.bin'],zeros(size(xaff)));

        fname = [subdir sprintf('x%d_y%d_z%d_lbl.bin',x,y,z)];
        export_volume(fname,patch.lbl);

    cd(current);

end