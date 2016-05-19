function ZALIS_random_patch_script( img, bdm, lbl, psz, xyz )

    % image size
    X = size(bdm,1);
    Y = size(bdm,2);
    Z = size(bdm,3);

    % random location
    if exist('xyz','var')
        x = xyz(1);
        y = xyz(2);
        z = xyz(3);
    else
        x = randi(X-psz(1)+1);
        y = randi(Y-psz(2)+1);
        z = randi(Z-psz(3)+1);
    end

    % extract patch
    patch.img = img(x:x+psz(1)-1,y:y+psz(2)-1,z:z+psz(3)-1);
    patch.bdm = bdm(x:x+psz(1)-1,y:y+psz(2)-1,z:z+psz(3)-1);
    patch.lbl = lbl(x:x+psz(1)-1,y:y+psz(2)-1,z:z+psz(3)-1);

    fprintf('\nextracted %dx%dx%d patch at (x,y,z) = (%d,%d,%d)\n', ...
            [psz x y z]);

    % run ZALIS
    ZALIS_script(patch.img, patch.bdm, patch.lbl);

end