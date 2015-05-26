function assess_result_script

    % options(1)    voxel error
    % options(2)    2D Rand error (connected component)
    % options(3)    2D Rand error (watershed)

    if ~exist('data','var')
        data = load_Ashwin_dataset;
    end

    list = cell2mat(get_exp_list);
    for i = 1:numel(list)

        disp(list(i).lgnd);
        cd(list(i).path);

        batch = list(i).batch;
        for j = 1:numel(batch)

            num = batch(j);
            disp(['batch' num2str(num)]);

            % output
            fname = [pwd '/out' num2str(num) '.1'];
            
            % load & assess missing ones
            sz  = size(data{num}.label);
            str = sprintf('x1_y1_z1_dim%dx%dx%d',sz);                
            
            rlist = dir([str '.mat']);
            if isempty(rlist)
                options = [1 1 1];
                assess_result(fname,data(num),[],[],[],options);
            else
                load([str '.mat']);
                fields = {'voxel','conn','ws'};
                options = [1 1 1];
                for i = 1:numel(fields)
                    if isfield(result,fields{i})
                        options(i) = 0;
                    end
                end
                assess_result(fname,data(num),[],[],[],options);
            end

            rlist = dir([str '.median5.mat']);
            if isempty(rlist)
                options = [1 1 1];
                assess_result(fname,data(num),[],[],5,options);
            else
                load([str '.median5.mat']);
                fields = {'voxel','conn','ws'};
                options = [1 1 1];
                for i = 1:numel(fields)
                    if isfield(result,fields{i})
                        options(i) = 0;
                    end
                end
                assess_result(fname,data(num),[],[],5,options);
            end

        end

    end

end