function h5_to_tif( fname, dataset, idx )

    if ~exist('dataset','var')
        dataset = '/main';
    end

    % Read HDF5 file.
    [fpath,fname,ext] = fileparts(fname);
    out = hdf5read([fname ext], dataset);

    % Save as tiff.
    dim = size(out,4);
    if dim == 1
        saveastiff(out, [fname '.tif']);
    else
        for i = 1:dim
            saveastiff(out(:,:,:,i), [fname '_' num2str(i-1) '.tif'] );
        end
    end

end
