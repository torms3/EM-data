function average_script()

    % outputs = [1 2 3 4 9 10];
    outputs = [2 3 4];

    exps = {'z9','z7','P2','P3'};
    % msk  = [1 2 3 4];
    msk  = [1 3 4];

    base = '/usr/people/kisuk/Workbench/seung-lab/znn-release/experiments/';
    dirs = {[base 'new_Piriform/VD2D3D/affinity/P1-F5/z9/exp1/iter_300K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/P1-F5/z7/exp1/iter_70K/exp1/iter_300K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/P2/exp2/iter_150K/'], ...
            [base 'new_Piriform/VD2D3D/affinity/P3/exp1/iter_100K/exp1/iter_120K/']
    };
    dst  = [base 'new_Piriform/VD2D3D/affinity/avg/' strjoin(exps(msk),'') '/'];
    if ~exist(dst,'dir'); mkdir(dst); end;

    for i = 1:numel(outputs)

        fname = sprintf('Piriform_sample%d_output',outputs(i));
        vols  = {};

        for j = 1:3

            idx = ['_' num2str(j-1)];

            for k = 1:numel(msk)

                disp(['cd ' dirs{msk(k)}]);
                cd(dirs{msk(k)});

                vols{k} = loadtiff([fname idx '.tif']);

            end

            avg = var(cat(4,vols{:}),ones(numel(dirs),1),4);
            saveastiff(avg,[dst fname idx '.var.tif']);

        end

    end

end