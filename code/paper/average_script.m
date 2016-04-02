function average_script()

    base = '/usr/people/kisuk/Workbench/seung-lab/znn-release/experiments/';

    % SNEMI3D
    % outputs = [6];
    % exps = {'P4','P3','P2','P1','P0'};
    % msk  = [1 2 3 4];
    % % first trial
    % % dirs = {[base 'multiscale/VD2D-avg/SNEMI3D/P4/exp2/iter_120K/'], ...
    % %         [base 'multiscale/VD2D-avg/SNEMI3D/P3/exp2/iter_150K/'], ...
    % %         [base 'multiscale/VD2D-avg/SNEMI3D/P2/exp2/iter_150K/'], ...
    % %         [base 'multiscale/VD2D-avg/SNEMI3D/P1-F5/exp3/iter_50K/exp1/iter_250K/'], ...
    % %         [base 'multiscale/VD2D-avg/SNEMI3D/P1-F7/exp2/iter_500K/'], ...
    % % };
    % % second trial
    % dirs = {[base 'multiscale/VD2D-avg/SNEMI3D/P4/exp2/iter_100K/exp1/iter_150K/'], ...
    %         [base 'multiscale/VD2D-avg/SNEMI3D/P3/exp2/iter_250K/'], ...
    %         [base 'multiscale/VD2D-avg/SNEMI3D/P2/exp2/iter_180K/exp1/iter_300K/'], ...
    %         [base 'multiscale/VD2D-avg/SNEMI3D/P1-F5/exp3/iter_50K/exp1/iter_250K/exp1/iter_350K/'], ...
    %         [base 'multiscale/VD2D-avg/SNEMI3D/P1-F7/exp2/iter_500K/'], ...
    % };
    % dst  = [base 'multiscale/VD2D-avg/SNEMI3D/avg/' strjoin(exps(msk),'') '/'];
    % if ~exist(dst,'dir'); mkdir(dst); end;

    % Pirifrom
    outputs = [1 2 3 9 10];
    exps = {'P3','P2','z5','z7','z9'};
    msk  = [1 2 3 4 5];
    dirs = {[base 'new_Piriform/VD2D3D/affinity/dropnode/P3/exp1/iter_80K/exp1/iter_100K/exp1/iter_190K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/dropnode/P2/exp1/iter_70K/exp1/iter_100K/exp1/iter_120K/exp1/iter_140K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/dropnode/z5/exp1/iter_100K/exp1/iter_160K/exp1/iter_180K/exp1/iter_200K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/dropnode/z7/exp1/iter_200K/exp1/iter_230K/exp1/iter_240K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/dropnode/z9/exp1/iter_100K/exp1/iter_150K/exp1/iter_180K/exp1/iter_190K/'], ...
    };
    dst  = [base 'new_Piriform/VD2D3D/affinity/dropnode/avg/' strjoin(exps(msk),'') '/'];
    if ~exist(dst,'dir'); mkdir(dst); end;

    for i = 1:numel(outputs)

        % SNEMI3D
        % fname = sprintf('SNEMI3D_sample%d_output',outputs(i));

        % Piriform
        fname = sprintf('Piriform_sample%d_output',outputs(i));

        vols  = {};

        % for j = 1:3 % affinity
        for j = 1:1 % boundary

            idx = ['_' num2str(j-1)];

            for k = 1:numel(msk)

                disp(['cd ' dirs{msk(k)}]);
                cd(dirs{msk(k)});

                vols{k} = loadtiff([fname idx '.tif']);

            end

            avg = mean(cat(4,vols{:}),4);
            saveastiff(avg,[dst fname idx '.tif']);

        end

    end

end
