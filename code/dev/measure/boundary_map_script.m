function boundary_map_script( prefix, samples, data, options )

    if ~iscell(data);     data = {data};end;
    if ~exist('options','var')
        % options(1)    pixel error
        % options(2)    2D Rand error (connected component)
        % options(3)    2D Rand error (watershed)
        options = [1 0 0];
    end

    for i = 1:numel(samples)
        fname = [prefix '_sample' num2str(samples(i)) '_output'];
        disp(['Processing ' fname '...']);
        assess_boundary_map(fname,data{i}.label);
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function assess_boundary_map( fname, label )

        bmap = loadtiff([fname '_0.tif']);

        %% Voxel error
        if options(1)
            [result.voxel] = optimize_voxel_error(bmap,label);
        end

        %% 2D Rand error
        % connected component
        if options(2)
            disp(['Processing 2D Rand error (connected component)...']);
            [result.conn] = optimize_2D_Rand_error(bmap,label);
        end

        %% 2D Rand error
        % watershed
        if options(3)
            disp(['Processing 2D Rand error (watershed)...']);
        end

        %% Save
        % if exist, update
        update_result([fname '.mat'],result);

    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function update_result( fname, update )

    if exist(fname,'file')
        load(fname);

        fields = {'voxel','conn','ws'};
        for i = 1:numel(fields)
            field = fields{i};
            if isfield(update,field)
                result.(field) = update.(field);
            end
        end
    else
        result = update;
    end

    save(fname,'result');

end