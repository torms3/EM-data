function h5_to_tif( fname, dataset, idx )

    if ~exist('dataset','var'); dataset = 'main'; end;

    out = hdf5read([fname '.h5'], ['/' dataset]);

    for i = 1:size(out,4)
        saveastiff(out(:,:,:,i), [fname '_' num2str(i-1) '.tif'] );
    end

end
