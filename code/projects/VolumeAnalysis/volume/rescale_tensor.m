function [ret] = rescale_tensor( tensor, scale )

    [X,Y,Z,W] = size(tensor);
    for w = 1:W
        ret(:,:,:,w) = rescale(tensor(:,:,:,w), scale);
    end

end
