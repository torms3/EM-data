function [ret] = rescale( vol, scale )

    [X,Y,Z] = size(vol);
    for z = 1:Z
        ret(:,:,z) = imresize(vol(:,:,z), scale);
    end

end
