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
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P1/exp3/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P2/exp3/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P4/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P1-F5/exp1/';
        idx = idx + 1;exps{idx} = 'multiscale/VD2D-avg/P1-F7-F5-F3/exp1/';

    end

end