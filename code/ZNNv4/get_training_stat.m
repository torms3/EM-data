function get_training_stat( cluster, fpath )

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

    % source & destination dirs
    src = [remote_base znn_base fpath 'network/net_statistics*'];
    dst = [local_base znn_base fpath 'network/'];

    % make dir if not exist
    prepare_dir([fpath 'network/']);

    % run starcluster command
    cmd = ['starcluster get ' cluster];
    cmd = [cmd ' ' src ' ' dst];
    disp(cmd);
    %system(cmd);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Prepare directory
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function prepare_dir( dpath )

        cur = [local_base znn_base];
        [token,remain] = strtok(dpath);
        while ~isempty(token)

            cur = [cur token '/'];
            if ~exist(cur,'dir')
                mkdir(cur);
            end
            [token,remain] = strtok(remain);
        end
    end

end
