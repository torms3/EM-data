function average_script()

    % fnames = {'Piriform_sample1_output', ...
    %           'Piriform_sample9_output', ...
    %           'Piriform_sample10_output'};
    fnames = {'Piriform_sample2_output', ...
              'Piriform_sample3_output', ...
              'Piriform_sample4_output'};

    base = '/usr/people/kisuk/Workbench/seung-lab/znn-release/experiments/';
    dirs = {[base 'new_Piriform/VD2D3D/affinity/P1-F5/z9/exp1/iter_300K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/P1-F5/z7/exp1/iter_70K/exp1/iter_300K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/P2/exp2/iter_150K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/P3/exp1/iter_100K/exp1/iter_120K/']
    };
    % dirs = {[base 'new_Piriform/VD2D3D/affinity/P1-F5/z7/exp1/iter_70K/exp1/iter_300K/'], ...
    %         [base 'new_Piriform/VD2D3D/affinity/P2/exp2/iter_150K/'], ...
    %         [base 'new_Piriform/VD2D3D/affinity/P3/exp1/iter_100K/exp1/iter_120K/']
    % };
    % dirs = {[base 'new_Piriform/VD2D3D/affinity/P1-F5/z9/exp1/iter_300K/'], ...
    %         [base 'new_Piriform/VD2D3D/affinity/P2/exp2/iter_150K/'], ...
    %         [base 'new_Piriform/VD2D3D/affinity/P3/exp1/iter_100K/exp1/iter_120K/']
    % };

    dst  = [base 'new_Piriform/VD2D3D/affinity/avg/z9z7P2P3/'];
    % dst  = [base 'new_Piriform/VD2D3D/affinity/avg/z7P2P3/'];
    % dst  = [base 'new_Piriform/VD2D3D/affinity/avg/z9P2P3/'];
    if ~exist(dst,'dir'); mkdir(dst); end;

    for i = 1:numel(fnames)

        fname = fnames{i};
        vols  = {};

        for j = 1:3

            idx = ['_' num2str(j-1)];

            for k = 1:numel(dirs)

                disp(['cd ' dirs{k}]);
                cd(dirs{k});

                vols{k} = loadtiff([fname idx '.tif']);

            end

            avg = mean(cat(4,vols{:}),4);
            saveastiff(avg,[dst fname idx '.tif']);

        end

    end

end
