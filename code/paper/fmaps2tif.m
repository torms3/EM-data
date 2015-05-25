function [] = fmaps2tif( fname, map, z )

    if ~exist('map','var'); map = []; end;
    if ~exist('z','var');     z = []; end;
    
    fmaps = import_tensor(fname);
    [X,Y,Z,M] = size(fmaps);

    if any(map)
        
        assert(map>0 & map<M);
        ret = squeeze(fmaps(:,:,:,map));
        fname = [fname '.map' num2str(map)];

        if any(z)
            assert(z>0 & z<=Z);
            ret = ret(:,:,z);
            fname = [fname '.z' num2str(z)];
        end
        
        write_tif_image_stack(ret,fname);
    else        
        if any(z)
            assert(z>0 & z<=Z);
            ret = fmaps(:,:,z,:);
            fname = [fname '.z' num2str(z)];
            write_tif_image_stack(ret,fname);
        else
            save_fmap;
        end
    end

    function save_fmap
        for map = 1:M
            fmap = fmaps(:,:,:,map);
            fname = [fname '.map' num2str(map)];
            write_tif_image_stack(fmap,fname);
        end
    end
end