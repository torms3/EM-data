function ret = optimize_Rand_score( ws_seg, gt_seg, mt )
%
%   ws_seg: watershed segmentation
%   gt_seg: ground truth segmentation
%   mt    : merge tree
%
    ws_seg = uint32(ws_seg);
    gt_seg = uint32(gt_seg);

    %% 1st pass
    % line search interval: 0.1
    disp(['1st pass...']);
    thresh = [0:0.1:1];
    [data] = iterate_over(thresh,{});

    %% 2st pass
    % line search interval: 0.05
    disp(['2nd pass...']);
    [~,I]  = max(extractfield(cell2mat(data),'rf'));
    pivot  = data{I}.thresh;
    thresh = union(thresh,[pivot-0.05,pivot+0.05]);
    thresh = thresh((thresh >= 0) & (thresh <= 1));
    [data] = iterate_over(thresh,data);

    %% 3rd pass
    % line search interval: 0.01
    disp(['3rd pass...']);
    [~,I]  = max(extractfield(cell2mat(data),'rf'));
    pivot  = data{I}.thresh;
    thresh = union(thresh,pivot-0.05:0.01:pivot+0.05);
    thresh = thresh((thresh >= 0) & (thresh <= 1));
    [data] = iterate_over(thresh,data);

    %% Return
    data   = cell2mat(data);
    ret.th = extractfield(data,'thresh');
    ret.rm = extractfield(data,'rm');
    ret.rs = extractfield(data,'rs');
    ret.rf = extractfield(data,'rf');


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function data = iterate_over( thresh, data )

        nThresh = numel(thresh);
        old = [];
        if ~isempty(data)
            old = extractfield(cell2mat(data),'thresh');
        end

        for i = 1:nThresh

            if any(ismember(old,thresh(i)))
                continue;
            end

            fprintf('(%d/%d)...threshold=%f\n',i,nThresh,thresh(i));
            seg = merge_regions(ws_seg,mt.vals,mt.pairs,thresh(i));
            score = compare_segmentation(uint32(seg),gt_seg);
            fprintf('merger  : %f\nsplitter: %f\n',score);

            D.thresh = thresh(i);
            D.rm     = score(1);
            D.rs     = score(2);
            D.rf     = D.rm*D.rs*2/(D.rm+D.rs);

            data{end+1} = D;

        end


    end

end