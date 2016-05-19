function [idx] = max_pool_over_scales( prefix, out )

    score{1} = loadtiff([prefix '_nscore-p1_' num2str(out) '.tif']);
    score{2} = loadtiff([prefix '_nscore-p2_' num2str(out) '.tif']);
    score{3} = loadtiff([prefix '_nscore-p3_' num2str(out) '.tif']);

    idx{1} = (score{1}>score{2}) & (score{1}>score{3});
    idx{2} = (score{2}>score{1}) & (score{2}>score{3});
    idx{3} = (score{3}>score{1}) & (score{3}>score{2});

    cellplay({score{1},score{2},score{3};idx{1},idx{2},idx{3}});

end