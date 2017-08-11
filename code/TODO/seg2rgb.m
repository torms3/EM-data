function [ret] = seg2rgb( seg, clrmap )

    [C,~,ic] = unique(seg);

    r = clrmap(:,1);
    g = clrmap(:,2);
    b = clrmap(:,3);

    R = reshape(r(ic),size(seg));
    G = reshape(g(ic),size(seg));
    B = reshape(b(ic),size(seg));

    ret = cat(4,R,G,B);

end
