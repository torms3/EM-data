function visualize_MALIS()

    [lbl,bmap] = simulate_data;
    [xaff,yaff] = make_affinity(bmap);

    % evolution & timestep
    ws = import_volume('out.evolution',[10 10 100],[],'uint64');
    ts = import_volume('out.timestep',[10 10 1],[],'uint64');

    % merger & splitter weights
    mw = import_volume('out.merger',[10 10 1]);
    sw = import_volume('out.splitter',[10 10 1]);

    data = {bmap,xaff,yaff;lbl,mw,sw};
    label = {'boundary map','x-affinity','y-affinity'; ...
             'label','merger weight','splitter weight'};
    [X,Y] = size(data);
    n = X*Y;
    idx = 1;
    figure;
    colormap('gray');
    for x = 1:X
        for y = 1:Y
            subplot(X,Y,idx);
            imagesc(data{x,y});
            xlabel(label{x,y});
            daspect([1 1 1]);
            idx = idx + 1;
        end
    end

    nSeg = max(unique(ws(:,:,1)));
    clrmap = rand(nSeg+1,3);
    figure;
    data = {ws(:,:,78),ws(:,:,79),ws(:,:,80); ...
            ws(:,:,81),ws(:,:,82),ws(:,:,83)};
    idx = 1;
    for x = 1:X
        for y = 1:Y
            subplot(X,Y,idx);
            image(data{x,y});
            xlabel(['merge step ' num2str(idx+77)]);
            daspect([1 1 1]);
            idx = idx + 1;
        end
    end
    colormap(clrmap);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [xaff,yaff] = make_affinity( map )

        xaff = zeros(size(map));
        yaff = zeros(size(map));

        xaff(2:end,:) = bsxfun(@min,map(1:end-1,:),map(2:end,:));
        yaff(:,2:end) = bsxfun(@min,map(:,1:end-1),map(:,2:end));

    end

end