function visualize_MALIS( lname, outname )

    % load ground truth segmentation
    lbl = import_volume(lname);

    % load affinity from the boundary prediction
    affs = import_tensor([outname '.affs']);
    xaff = affs(:,:,:,1);
    yaff = affs(:,:,:,2);

    % merger & splitter weights
    mw = import_tensor([outname '.merger']);
    sw = import_tensor([outname '.splitter']);

    aff   = (xaff+yaff)/2;
    data  = {aff,mw; lbl,sw};
    clr   = {'gray','hot'; '','hot'};
    label = {'affinity','merger weight'; 'ground truth','splitter weight'};
    alpha = {[],aff; [],aff};
    cellplay(data,'clr',clr,'label',label,'alpha',alpha);

end