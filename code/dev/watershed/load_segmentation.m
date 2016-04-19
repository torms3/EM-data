function [seg,mt] = load_segmentation( fname )

    % segmentation
    seg = hdf5read([fname '.h5'],'/main');

    % merge tree
    dendValues = hdf5read([fname '.h5'],'/dendValues');
    [dendValues,idx] = sort(dendValues,'descend');
    mt.vals = double(dendValues);

    dend = hdf5read([fname '.h5'],'/dend');
    dend = dend(idx,:);
    mt.pairs = uint32(reshape(dend',[],1));

end