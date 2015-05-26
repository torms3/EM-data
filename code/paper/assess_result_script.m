function assess_result_script( options )

    if ~exist('options','var')
        % options(1)    voxel error
        % options(2)    2D Rand error (connected component)
        % options(3)    2D Rand error (watershed)
        options = [1 1 1];
    end
    if ~exist('data','var')
        data = load_Ashwin_dataset;
    end

    list = cell2mat(get_exp_list);
    for i = 1:numel(list)

        disp(list(i).lgnd);
        cd(list(i).path);

        batch = list(i).batch;
        for j = 1:numel(batch)

            num = num2str(batch(j));
            disp(['batch' num])

            % output
            fname = {[pwd 'out' num '.1']};
            
            assess_result(fname,data(num),[],[],[],options);
            assess_result(fname,data(num),[],[],5,options);

        end

    end

end