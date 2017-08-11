function h5_to_tif( fname, dataset )

    if ~exist('dataset','var'); dataset = 'main'; end;

    out = hdf5read([fname '.h5'], ['/' dataset]);

    dim4 = size(out,4);
    if dim4 == 1
        saveastiff(out, [fname '.tif'] );
    else
        for i = 1:dim4
            saveastiff(out(:,:,:,i), [fname '_' num2str(i-1) '.tif'] );
        end

end
