function v4script()

    fnames = {'Piriform_sample1_output_0', ...
              'Piriform_sample2_output_0', ...
              'Piriform_sample3_output_0', ...
              'Piriform_sample4_output_0'};

    base = '/usr/people/kisuk/Workbench/seung-lab/znn-release/experiments/';
    dirs = {[base 'multiscale/VD2D-aug/exp1/iter_100K/']};

    % load data set
    data = load_Ashwin_dataset;

    % run script in each of the specified dirs
    current = pwd;
    for i = 1:numel(dirs)
        disp(['cd ' dirs{i}]);cd(dirs{i});
        v4script_dir;
    end
    cd(current);


    function v4script_dir

        % convert v4 .tif file to v1 binary
        for idx = 1:numel(fnames)

            fname = fnames{idx};
            if exist(fname,'file') ~= 2
                v4tif_to_v1vol([fname '.tif']);
            end

        end

        % assess result
        assess_result( fnames, data, [1 1 1] );

    end

end
