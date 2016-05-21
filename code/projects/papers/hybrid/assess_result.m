function assess_result( fname, data, options, offset, FoV, filtrad, gpath )

    if ~iscell(fname);      fname = {fname};end;
    if ~iscell(data);         data = {data};end;
    if ~exist('offset','var');  offset = [];end;
    if ~exist('FoV','var');        FoV = [];end;
    if ~exist('filtrad','var'); filtrad = 0;end;
    if ~exist('gpath','var');    gpath = '';end;

    if ~exist('options','var')
        % options(1)    voxel error
        % options(2)    2D Rand error (connected component)
        % options(3)    2D Rand error (watershed)
        options = [1 1 0];
    end

    disp('options');
    disp(options);

    for i = 1:numel(fname)
        if isfield(data{i},'mask')
            mask = data{i}.mask;
        else
            mask = true(size(data{i}.label));
        end
        disp(['Processing ' fname{i} '...']);
        gpath = data{i}.gpath;
        assess_boundary(fname{i},data{i}.label,mask);
    end


    function assess_boundary( fname, label, mask )

        % prepare boundary map
        bmap = prepare_boundary_map(fname,filtrad);

        % coordinate correction
        if ~isempty(offset)
            bmap.coord = bmap.coord + offset;
            fprintf('Coordinate = [%d,%d,%d]\n',bmap.coord);
        end

        % crop FoV
        if ~isempty(FoV)
            offs = floor(FoV/2) + [1,1,1];
            sz   = bmap.size - FoV + [1,1,1];
            bmap = crop_result(bmap,offs,sz);
        end

        % prpare ground truth
        GT    = prepare_ground_truth(label,bmap,mask);
        truth = GT.label;
        mask  = GT.mask;


        %% Voxel error
        %
        if options(1)
            disp(['Processing voxel error...']);
            [result.voxel] = optimize_voxel_error(bmap.prob,truth,mask);
        end


        %% 2D Rand error (simple thresholding + connected component)
        %
        if options(2)
            disp(['Processing 2D Rand error (conn)...']);
            [result.conn] = optimize_2D_Rand_error(bmap.prob,truth,mask);
        end


        %% 2D Rand error (watershed)
        %
        if options(3)
            disp(['Processing 2D Rand error (watershed)...']);
            ipath = fname;
            [result.ws,result.zws] = optimize_2D_zished(ipath,gpath);
        end


        %% Save
        %
        ox  = bmap.coord(1);oy = bmap.coord(2);oz = bmap.coord(3);
        sx  = bmap.size(1); sy = bmap.size(2); sz = bmap.size(3);
        str = sprintf('x%d_y%d_z%d_dim%dx%dx%d',ox,oy,oz,sx,sy,sz);

        % fname = [fname '.' str];
        if filtrad > 0
            fname = [fname '.median' num2str(filtrad)];
        end

        % if exist, update
        update_result([fname '.mat'],result);

    end

end

%% Update result
%
function update_result( fname, update )

    if exist(fname,'file')
        load(fname);

        fields = {'voxel','conn','ws','zws'};
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