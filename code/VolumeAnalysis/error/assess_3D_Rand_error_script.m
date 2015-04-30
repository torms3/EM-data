function assess_3D_Rand_error_script( fname, data, offset, FoV, filtrad )

    if ~iscell(fname);      fname = {fname};end;
    if ~iscell(data);         data = {data};end;
    if ~exist('offset','var');  offset = [];end;
    if ~exist('FoV','var');        FoV = [];end;
    if ~exist('filtrad','var'); filtrad = 0;end;

    for i = 1:numel(fname)      
        if isfield(data{i},'mask')
            mask = data{i}.mask;
        else
            mask = true(data{i}.label);
        end
        assess_affinity_graph(fname{i},data{i}.label,mask,offset,FoV,filtrad);
    end


    function assess_affinity_graph( fname, label, mask, offset, FoV, filtrad )

        % prepare affinity graph
        [affin] = prepare_affinity_graph(fname,filtrad);
        
        % coordinate correction
        if ~isempty(offset)
            affin.coord = affin.coord + offset;
            fprintf('affinity graph coordinate = [%d,%d,%d]\n',affin.coord);
        end

        % crop FoV
        if ~isempty(FoV)
            offs    = floor(FoV/2) + [1,1,1];
            sz      = affin.size - FoV + [1,1,1];
            [affin] = crop_affinity_graph(affin,offs,sz);
        end

        % prpare ground truth affinith graph
        [GT] = prepare_affinity_truth(label,affin,mask);


        %% 3D Rand error
        %
        disp(['Processing 3D Rand error...']);
        thresh = [0.001 0.1:0.1:0.5 0.6:0.01:0.8 0.9 0.999];
        [result] = optimize_3D_Rand_error(affin,GT,thresh);


        %% Save
        %       
        ox = affin.coord(1);
        oy = affin.coord(2);
        oz = affin.coord(3);

        sx = affin.size(1);
        sy = affin.size(2);
        sz = affin.size(3);

        str = sprintf('x%d_y%d_z%d_dim%dx%dx%d',ox,oy,oz,sx,sy,sz);
            
        fname = [fname '.3DRand.' str];

        if filtrad > 0
            fname = [fname '.median' num2str(filtrad)];
        end

        save([fname '.mat'],'result');

    end

end