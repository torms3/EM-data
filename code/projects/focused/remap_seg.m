function [seg] = remap_seg( seg, bdr )

    [C,~,ic] = unique(seg);
    remap = (1:numel(C)) - bdr;
    seg = reshape(remap(ic),size(seg));

end
