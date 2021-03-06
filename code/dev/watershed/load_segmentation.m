function [seg,mt] = load_segmentation( fname )

    % Segmentation.
    seg = hdf5read(fname,'/main');

    % Merge tree.
    dendValues = hdf5read(fname,'/dendValues');
    [dendValues,idx] = sort(dendValues,'descend');
    mt.vals = double(dendValues);

    dend = hdf5read(fname,'/dend');
    dend = dend(idx,:);
    mt.pairs = uint32(reshape(dend',[],1));

end
