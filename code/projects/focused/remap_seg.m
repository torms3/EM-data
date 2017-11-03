function [seg] = remap_seg( seg, bdr )

    if ~exist('bdr','var'); bdr = 1; end;

    [C,~,ic] = unique(seg);
    remap = (1:numel(C)) - bdr;
    seg = reshape(remap(ic),size(seg));

end
