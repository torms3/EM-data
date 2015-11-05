function average_script()

    fnames = {'Piriform_sample1_output_0', ...
              'Piriform_sample2_output_0', ...
              'Piriform_sample3_output_0', ...
              'Piriform_sample4_output_0'};

    base = '/usr/people/kisuk/Workbench/seung-lab/znn-release/experiments/';
    dirs = {[base 'multiscale/VD2D-avg/P1/exp2/iter_250K/'], ...
            [base 'multiscale/VD2D-avg/P2/exp2/iter_250K/'], ...
            [base 'multiscale/VD2D-avg/P3/exp2/iter_150K/'], ...
            [base 'paper/VD2D/exp5/iter_60K/exp2/iter_150K/']  ...
    };
    dst  = [dirs{4} 'VD2D-avg/'];
    if ~exist(dst,'dir'); mkdir(dst); end;

    for i = 1:numel(fnames)

        fname = fnames{i};
        vols  = {};
        for j = 1:numel(dirs)

            disp(['cd ' dirs{j}]);
            cd(dirs{j});

            vols{j} = loadtiff([fname '.tif']);

        end

        avg = mean(cat(4,vols{:}),4);
        saveastiff(avg,[dst fname '.tif']);

    end

end
