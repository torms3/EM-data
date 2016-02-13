function affinity_graph_script( fname, data, options )

    if ~iscell(fname);  fname = {fname};end;
    if ~iscell(data);     data = {data};end;
    if ~exist('options','var')
        % options(1)    voxel error
        % options(2)    3D Rand error (watershed)
        options = [1 0];
    end

    for i = 1:numel(fname)
        disp(['Processing ' fname{i} '...']);
        assess_affinity_graph(fname{i},data{i}.label);
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function assess_affinity_graph( fname, label )

        %% Voxel error
        if options(1)
            result = compute_affinty_voxel_error(fname,label);
        end

        %% 2D Rand error
        % connected component
        if options(2)
            disp(['Processing 3D Rand error (watershed)...']);
            % [result.ws] = optimize_3D_Rand_error(affin,truth);
        end

        %% 2D Rand error
        % watershed
        if options(2)
            disp(['Processing 3D Rand error (watershed)...']);
            % [result.ws] = optimize_3D_Rand_error(affin,truth);
        end

        %% 3D Rand error
        % watershed
        if options(2)
            disp(['Processing 3D Rand error (watershed)...']);
            % [result.ws] = optimize_3D_Rand_error(affin,truth);
        end

        %% Save
        % if exist, update
        update_result([fname '.mat'],result{1});

    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function update_result( fname, update )

    if exist(fname,'file')
        load(fname);

        fields = {'x','y','z','ws'};
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