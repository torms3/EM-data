function [msk] = create_valid_mask( seg, seginfo )

    uIDs = unique(seg);

    % Valid segment IDs.
    [C,ia,~] = intersect(seginfo.segIDs, uIDs);
    idx = ia(seginfo.status(ia)==2);
    val = seginfo.segIDs(idx);

    % Membership.
    idx = ismember(seg(:),val(:));

    % Valid mask.
    msk = uint8(reshape(idx,size(seg)));

end
