function [ret] = semantic( seg, map )

    [~,~,ic] = unique(seg);
    ret = reshape(map(ic),size(seg));
    
end
