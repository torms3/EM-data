function ret = rgb2seg( rgb, renumber )

    if ~exist('renumber','var'); renumber = true; end;

    rgb = permute(rgb,[1 2 4 3]);
    dim = size(rgb);
    if renumber
        stack = reshape(rgb,dim(1)*dim(2)*dim(3),dim(4));
        [C,ia,ic] = unique(stack,'rows');
        ret = reshape(ic-1,dim(1),dim(2),dim(3));
    else
        % collapse
        b = rgb(:,:,:,end);
        rgb = sum(rgb,4);
        assert(isequal(rgb,b));
        ret = rgb;
    end

end
