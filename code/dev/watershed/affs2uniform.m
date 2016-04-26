function [affs] = affs2uniform( affs )

    [~,idx]   = sort(affs(:),'ascend');
    affs(idx) = linspace(0,1,numel(affs(:)));

end