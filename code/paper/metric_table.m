function list = metric_table()

    % batch name
    batchname = {'7nm-512pix (Training)';     ...
                 '7nm-notTrained (Training)'; ...
                 '7nm-IDSIA (Validation)'};
    nbatch = numel(batchname);

    % experiment list
    list = cell2mat(get_exp_list);
    row = extractfield(list,'str');
    nexp = numel(row);

    % collect measurements
    for i = 1:numel(list)

        disp(list(i).lgnd);
        cd(list(i).path);

        batch = list(i).batch;
        for j = 1:numel(batch)

            % load
            file = dir(['out' num2str(batch(j)) '*.mat']);
            load(file(1).name,'result');
            
            % measurements
            if exist('result','var')
                list(i).pixel(j)   = min(result.voxel.err);
                list(i).rand2D(j)  = min(result.conn.re);
            else
                list{i}.pixel(j)   = nan;
                list{i}.rand2D(j)  = nan;
            end
            clear result;
        end
    end

    % table
    col = {'Pixel','Rand2D'};
    pix = extractfield(list,'pixel');
    rnd = extractfield(list,'rand2D');
    pix = reshape(pix,nbatch,nexp)';
    rnd = reshape(rnd,nbatch,nexp)';
    tbl = table(pix,rnd,'RowNames',row,'VariableNames',col);
    disp(tbl);

end