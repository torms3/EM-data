function export_random_patch( bname, lname, fsz, psz )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'bname',@(x)exist(x,'file'));
    addRequired(p,'lname',@(x)exist(x,'file'));
    addRequired(p,'fsz',@(x)isnumeric(x)&&(x>0));
    addRequired(p,'psz',@(x)isnumeric(x)&&(x>0));
    parse(p,bname,lname,fsz,psz);

    assert(psz<=fsz);

    bmap = import_volume(bname,[fsz fsz 1]);
    lbl  = import_volume(lname,[fsz fsz 1]);

    % random location
    x = randi(fsz-psz+1);
    y = randi(fsz-psz+1);

    % extract patch
    patch.bmap = bmap(x:x+psz-1,y:y+psz-1);
    patch.lbl  = lbl(x:x+psz-1,y:y+psz-1);

    % export patch
    fname = sprintf('bmap_%dx%d.bin',psz,psz);
    export_volume(fname,patch.bmap);
    fname = sprintf('lbl_%dx%d.bin',psz,psz);
    export_volume(fname,patch.lbl);

    % visualization
    interactive_multiplot({patch.bmap,patch.lbl},[0 1]);

end