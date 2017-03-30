function [ret] = create_border_mask( stack, max_dist, overlay )

    [X,Y,Z] = size(stack);
    ret = zeros(X,Y,Z);
    for z = 1:Z
        slice = stack(:,:,z);
        ret(:,:,z) = create_border_mask_2D(slice, max_dist, overlay);
    end

end
