function crawl_training_stats

    % local base dir
    cur = pwd;
    cd(get_project_root_path);
    cd('..');
    local_base = pwd;
    cd(cur);

    % remote base dir
    remote_base = '/home';

    % ZNN exps base dir
    znn_base = '/znn-release/experiments/';

    % exp list
    exps = exp_list;

    % starcluster config file
    cfg = [local_base '/znn-release/python/aws_train/EyeWire_config'];

    % cluster name
    cluster = 'intel';

    % crawling
    for i = 1:numel(exps)

        src = [remote_base znn_base exps{i} 'network/net_statistics.h5'];
        dst = [local_base znn_base exps{i} 'network/'];

        cmd = ['starcluster get ' cluster];
        cmd = [cmd ' ' src ' ' dst];

        disp(cmd);
        system(cmd);

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % exp list
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    function exps = exp_list()

        idx = 0;
        idx = idx + 1;exps{idx} = 'paper/N4/exp2/';
        idx = idx + 1;exps{idx} = 'paper/VD2D/exp5/iter_60K/exp1/';
        idx = idx + 1;exps{idx} = 'paper/VD2D/exp5/iter_60K/exp2/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-aug/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-MS/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-MS/exp2/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-MS/exp3/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-MS-maxout/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-MS-maxout/exp2/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-MS-maxout/exp3/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-MS-R/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-MS-R-maxout/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P1/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P1/exp2/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P2/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P2/exp2/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P3/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P3/exp2/';

    end

end