function [affs] = softmax_affinity( prefix, sample, lname )

    if ~exist('lname','var'); lname = 'output'; end;

    fname = [prefix '_sample' num2str(sample) '_' lname];

    C = {};
    for i = 1:6
        C{i} = loadtiff([fname '_' num2str(i-1) '.tif']);
    end

    % apply softmax
    p = cat(4,C{1:3});
    n = cat(4,C{4:6});
    affs = exp(p)./(exp(p)+exp(n));

end