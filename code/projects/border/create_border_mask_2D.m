function [ret] = create_border_mask_2D( slice, max_dist, overlay )

    % Maximum Euclidean distance for border.
    max_dist = max(max_dist, 0);

    % Create border mask.
    border = get_border_mask_2D( slice );

    % Distance transform and thresholding.
    border = bwdist(~border) > max_dist;

    % Overlay border on top of the segmentation.
    if overlay
        ret = slice;
        ret(~border) = 0;
    end

end
