function C = partition_volume( vol, shape )

    assert(ndims(vol)==3);
    assert(numel(shape)==3);

    X = size(vol,1); sx = floor(X/shape(1));
    Y = size(vol,2); sy = floor(Y/shape(2));
    Z = size(vol,3); sz = floor(Z/shape(3));

    dim1Dist = sx*ones(1,shape(1));
    dim2Dist = sy*ones(1,shape(2));
    dim3Dist = sz*ones(1,shape(3));

    dim1Dist(end) = dim1Dist(end) + mod(X,sx);
    dim2Dist(end) = dim2Dist(end) + mod(Y,sy);
    dim3Dist(end) = dim3Dist(end) + mod(Z,sz);

    C = mat2cell(vol,dim1Dist,dim2Dist,dim3Dist);

end