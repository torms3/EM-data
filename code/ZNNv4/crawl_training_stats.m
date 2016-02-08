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
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P1-F7/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P2/exp2/iter_180K/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P3/exp2/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-avg/SNEMI3D/P4/exp2/iter_100K/exp1/';

            % New Piriform
            % idx=idx+1;exps{idx}='new_Piriform/N4/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/N4/exp1/iter_130K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D/exp1/iter_150K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D-tanh/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D-avg/P1-F5/exp1/iter_300K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D-avg/P1-F7/exp2/iter_100K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P1/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P1-F5/exp1/iter_150K/exp2/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P2/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/P3/exp1/';

            % affinity
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P3/exp1/iter_100K/exp1/iter_120K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P2/exp2/iter_150K/exp2/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/exp1/iter_300K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z7/exp1/iter_70K/exp1/iter_300K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z5/exp2/';

            % recursive affinity
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/recursive/P1-F5/z9/exp2/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/recursive/P1-F5/z9/exp2/iter_330K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/recursive/P1-F5/z7/exp2/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/recursive/P1-F5/z5/exp2/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/recursive/MS/exp1/';

            % pretrain affinity
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P3/pretrain/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P2/pretrain/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/pretrain/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z7/pretrain/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z5/pretrain/exp1/';

            % multiscale affinity
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS/exp1/iter_80K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS/pretrain/exp1/iter_200K/exp1/iter_300K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS-maxout/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS-maxout/exp1/iter_80K/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/MS-maxout/pretrain/exp2/';

	    % multiscale maxpool
            % idx=idx+1;exps{idx}='multiscale/VD2D-MS-maxpool/SNEMI3D/exp1/iter_50K/exp1/';
            % idx=idx+1;exps{idx}='multiscale/VD2D-MS-maxpool/Piriform/original/exp1/';
            % idx=idx+1;exps{idx}='new_Piriform/VD2D-MS/maxpool/exp1/';

    	    % nodeout
    	    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P3/nodeout/exp2/';
    	    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P2/nodeout/exp1/';
    	    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z5/nodeout/exp2/';
    	    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z7/nodeout/exp2/';
    	    idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/nodeout/exp2/iter_100K/exp1/';

            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P3/nodeout/double_nodes/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P2/nodeout/double_nodes/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z5/nodeout/double_nodes/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z7/nodeout/double_nodes/exp2/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/nodeout/double_nodes/exp1/';

	    % batch normalization
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z5/normalize/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z7/normalize/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/normalize/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P2/normalize/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P3/normalize/exp1/';

	    % residual
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/residual/exp1/';
            idx=idx+1;exps{idx}='new_Piriform/VD2D3D/affinity/P1-F5/z9/residual/exp2/';
        otherwise
            assert(false);
        end

    end

end
