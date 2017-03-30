function [seg] = remap_seg( seg )

    [C,~,ic] = unique(seg);
    remap = (1:numel(C)) - 1;
    seg = reshape(remap(ic),size(seg));

end
