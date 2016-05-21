function visualize_MALIS_debug( lname, outname, timestamp )

    if ~exist('timestamp','var'); timestamp = false; end;

    % load ground truth segmentation
    lbl = import_volume(lname);

    % load affinity from the boundary prediction
    affs = import_tensor([outname '.affs']);
    xaff = affs(:,:,:,1);
    yaff = affs(:,:,:,2);
    aff  = (xaff+yaff)/2;

    % load watershed domain snapshots & time-stamp (for visualization)
    [ws] = load_snapshots(outname);

    % merger & splitter weights
    mw = import_tensor([outname '.merger']);
    sw = import_tensor([outname '.splitter']);

    if timestamp
        % time-unfold merger & splitter weights for visualization
        unfolded = unfold_weights(mw,sw,ws);

        % prepare data for visualization
        mw = squeeze(unfolded.mw); mw = squeeze(sum(mw,3));
        sw = squeeze(unfolded.sw); sw = squeeze(sum(sw,3));

        % convert weight to indexed hot colormap
        step = 64;
        [mw,mclrmap] = get_indexed_clrmap(mw,'hot',step);
        [sw,sclrmap] = get_indexed_clrmap(sw,'hot',step);

        aff   = repmat(aff,1,1,size(mw,3));
        clr   = {mclrmap,sclrmap,'';'gray','gray',''};
        alpha = {aff,aff,[]; [],[],[]};
    else
        % prepare data for visualization
        mw = sum(squeeze(mw),3);
        sw = sum(squeeze(sw),3);

        clr   = {'hot','hot','';'gray','gray',''};
        alpha = {aff,aff,[]; [],[],[]};
    end

    data  = {mw,sw,squeeze(ws.snapshots);xaff,yaff,lbl};

    label = {'merger weight','splitter weight','watershed domains'; ...
                 'x-affinity','y-affinity','ground truth'};

    cellplay(data,'clr',clr,'label',label,'alpha',alpha);

end