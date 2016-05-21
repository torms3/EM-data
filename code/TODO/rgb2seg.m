function ret = rgb2seg( rgbstack )

    rgbstack = permute(rgbstack,[1 2 4 3]);
    dim = size(rgbstack);
    stack = reshape(rgbstack,dim(1)*dim(2)*dim(3),dim(4));
    [C,ia,ic] = unique(stack,'rows');
    ret = reshape(ic-1,dim(1),dim(2),dim(3));

end