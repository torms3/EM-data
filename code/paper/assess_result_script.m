function assess_result_script()

    if ~exist('data','var')
        data = load_Ashwin_dataset;
    end

    list = cell2mat(get_exp_list);
    for i = 1:numel(list)

        disp(list{i}.lgnd);
        cd(list{i}.path);

        batch = list{i}.batch;
        for j = 1:numel(batch)

            num = num2str(batch(j));

            % output
            out = dir(['out' num '.1']);            

            % load
            file = dir(['out' num '*.mat']);
            load(file(1).name,'result');
            
            % metrics
            list{i}.pixel(j)   = min(result.voxel.err);
            list{i}.rand2D(j)  = min(result.conn.re);

        end

    end

end