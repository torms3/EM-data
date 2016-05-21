function exps = report_measurements( list )

    % for common use
    row = {'voxel','conn','ws','zws'};

    % for each exp
    cur    = pwd;
    cols   = [];
    vnames = {};
    for i  = 1:numel(list)

        expinfo = list{i};

        cd(expinfo.err);
        for j = 1:numel(expinfo.batch)

            batch = expinfo.batch(j);
            fname = sprintf(expinfo.fname,batch);
            col   = extract_measurement(fname);
            cols  = [cols col];

            vnames{j} = sprintf(expinfo.bname,batch);

        end

        exps{i}.tbl  = array2table(cols,'VariableNames',vnames,'RowNames',row);
        exps{i}.lgnd = expinfo.lgnd;

        % report
        disp(expinfo.lgnd);
        disp(exps{i}.tbl);

        % reset
        cols   = [];
        vnames = {};

    end
    cd(cur);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function col = extract_measurement( fname )

        data = load(fname);
        assert(isfield(data,'result'));
        result = data.result;

        % measurement type
        col = [];
        for ii = 1:numel(row)
            mtype = row{ii};
            if isfield(result,mtype)
                if strcmp(mtype,'voxel')
                    min_err = min(result.(mtype).err);
                else
                    min_err = min(result.(mtype).re);
                end
                col = [col;min_err];
            end
        end

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function tbl = report_measurement( fname )

        col = extract_measurement(fname);

        % report table
        tbl = table(col,'VariableNames',{'best'},'RowNames',row);
        disp(tbl);

    end

end