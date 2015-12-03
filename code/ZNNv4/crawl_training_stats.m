function crawl_training_stats

    % cluster name
    clusters{1} = 'intel';
    clusters{2} = 'intel-1c';

    % crawling
    for i = 1:numel(clusters)

        exps = exp_list(i);

        for j = 1:numel(exps)
            get_training_stat(clusters{i},exps{j});
        end

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Experiments list
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function exps = exp_list( ncluster )

        exps = {};
        idx  = 0;

        switch ncluster
        case 1
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P1-F5/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P1-F5/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P2/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P2/exp1/iter_30K/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P2/exp1/iter_30K/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P3/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P3/exp1/iter_30K/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P4/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P4/exp1/iter_20K/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P1-F5/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P1-F5/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P2/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P3/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P4/exp1/';
        case 2
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P1-F5/exp3/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P1-F5/exp3/iter_50K/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P2/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P3/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/Piriform/ground_truth/P4/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P1-F5/exp3/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P1-F5/exp3/iter_50K/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P1-F5/exp3/iter_50K/exp1/iter_250K/exp1/';
            idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P1-F7/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P2/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P2/exp2/iter_180K/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P3/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P4/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P4/exp2/iter_120K/exp1/';

            % New Piriform
            % idx=idx+1;exps{idx}='new_Piriform/N4/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/N4/exp1/iter_130K/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D/exp1/iter_150K/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D-tanh/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D-avg/P1-F5/exp1/iter_300K/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D-avg/P1-F7/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P1/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P1-F5/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P1-F5/exp1/iter_150K/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P2/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P3/exp1/';

            % affinity
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P3/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P2/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z7/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z5/exp1/';
        otherwise
            assert(false);
        end

    end

end