function [ret] = constrain_affinity( true_affs, affs, phase, thresh )

    if ~exist('thresh','var'); thresh = 0.5; end;

    assert(isequal(size(true_affs),size(affs)));

    ret = affs;

    switch phase
    case 'merger'
        idx = true_affs >= thresh;
    case 'splitter'
        idx = true_affs < thresh;
    otherwise
        assert(false);
    end

    ret(idx) = true_affs(idx);

end