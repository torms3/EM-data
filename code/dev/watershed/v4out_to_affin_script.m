function v4out_to_affin_script()

    % local base dir
    cur = pwd;
    cd(get_project_root_path);
    cd('..');
    local_base = pwd;
    cd(cur);

    % ZNN exps base dir
    znn_base = '/znn-release/experiments/';

    % experiment list
    idx=0;

    % affinity
    % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P3/exp1/iter_100K/exp1/iter_120K/';
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P2/exp2/iter_150K/';
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/exp1/iter_300K/';
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z7/exp1/iter_70K/exp1/iter_300K/';

    % average
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/avg/z9z7P2P3/';
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/avg/z9P2P3/';
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/avg/z7P2P3/';

    % multiscale
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS/exp1/iter_150K/';
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS/pretrain/exp1/iter_200K/exp1/iter_300K/';
    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS-maxout/exp1/iter_150K/';

    % output list
    outputs = [1 2 3 4 9 10];

    % traverse & convert
    for i = 1:numel(exps)

        cd([local_base znn_base exps{i}]);
        disp(pwd);

        for j = 1:numel(outputs)
            fname = sprintf('Piriform_sample%d_output',outputs(j));
            disp(fname);
            v4out_to_affin(fname);
        end

    end
    cd(cur);

end