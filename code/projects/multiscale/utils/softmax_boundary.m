function [ret] = softmax_boundary( prefix, sample, lname, idx )

    fname = [prefix '_sample' num2str(sample) '_' lname];

    C = {};
    for i = 1:numel(idx)
        C{i} = loadtiff([fname '_' num2str(idx(i)) '.tif']);
    end

    % apply softmax
    ret = exp(C{1})./(exp(C{1})+exp(C{2}));

end