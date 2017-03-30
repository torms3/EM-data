function postprocess_focused_patch( patches, k )

    if ~exist('k','var'); k = 10; end;

    for i = 1:numel(patches)
        dirname = sprintf('patch%.2d',i);
        mkdir(dirname);
        % Data.
        img = patches{i}.img;
        seg = patches{i}.seg;
        msk = patches{i}.msk;
        % Save.
        hdf5write([dirname '/img.h5'],'/main', uint8(img));
        hdf5write([dirname '/seg.h5'],'/main',uint16(seg));
        hdf5write([dirname '/msk.h5'],'/main', uint8(msk));
        % Dilate by k.
        sysargs = ['~/Data_local/datasets/utils/dilate.jl'];
        sysargs = [sysargs ' ' dirname '/seg'];
        sysargs = [sysargs ' ' num2str(k)];
        sysline = ['julia ' sysargs];
        [~,cmdout] = system(sysline);
        disp(cmdout);
        % Create border.
        segk = hdf5read([dirname '/seg.d' num2str(k) '.h5'],'/main');
        % Border 0.
        segk_b = create_border_mask(segk,0,true);
        fname = sprintf('seg.d%d.b%d.h5',k,0);
        hdf5write([dirname '/' fname],'/main',uint16(segk_b));
        % Border 1.
        segk_b = create_border_mask(segk,1,true);
        fname = sprintf('seg.d%d.b%d.h5',k,1);
        hdf5write([dirname '/' fname],'/main',uint16(segk_b));
    end

end
