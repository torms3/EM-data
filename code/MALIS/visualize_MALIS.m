function visualize_MALIS( bname, lname, outname )

    bmap = import_volume(bname);
    lbl  = import_volume(lname);

    [xaff,yaff] = make_affinity(bmap);

    % evolution & timestep
    ws = import_tensor([outname '.evolution'],[],[],'uint64');
    % ts = import_volume('out.timestep',[],[],'uint64');

    % merger & splitter weights
    mw = import_tensor([outname '.merger']); mw = squeeze(mw);
    sw = import_tensor([outname '.splitter']); sw = squeeze(sw);

    data = {xaff,sum(mw,3),squeeze(ws); ...
            yaff,sum(sw,3),lbl};
    clr = {'gray','hot',''; ...
           'gray','hot',''};

    label = {'x-affinity','merger weight','evolution'; ...
             'y-affinity','splitter weight','ground truth'};

    cellplay(data,'clr',clr,'label',label);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [xaff,yaff] = make_affinity( map )

        xaff = zeros(size(map));
        yaff = zeros(size(map));

        xaff(2:end,:) = bsxfun(@min,map(1:end-1,:),map(2:end,:));
        yaff(:,2:end) = bsxfun(@min,map(:,1:end-1),map(:,2:end));

    end

end