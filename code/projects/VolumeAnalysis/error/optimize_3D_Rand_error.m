function [ret] = optimize_3D_Rand_error( affin, truth, mask, thresh )

    if ~exist('mask','var');mask = [];end;
    if ~exist('thresh','var')
        thresh = [0.001 0.1:0.1:0.9 0.999];
    end

    %% 1st pass
    % resolution = 0.1
    disp(['1st pass...']);
    [RI] = iterate_over(thresh);


    %% 2st pass
    % resolution = 0.05
    disp(['2nd pass...']);
    [~,I]  = min(extractfield(cell2mat(RI),'re'));
    pivot  = RI{I}.thresh;
    thresh = union(thresh,[pivot-0.05,pivot+0.05]);
    [RI]   = iterate_over(thresh);


    %% 3rd pass
    % resolution = 0.01
    disp(['3rd pass...']);
    [~,I]  = min(extractfield(cell2mat(RI),'re'));
    pivot  = RI{I}.thresh;
    thresh = union(thresh,pivot-0.05:0.01:pivot+0.05);
    [RI]   = iterate_over(thresh);


    %% Return
    %
    RI = cell2mat(RI);

    ret.thresh = extractfield(RI,'thresh');
    ret.prec   = extractfield(RI,'prec');
    ret.rec    = extractfield(RI,'rec');
    ret.re     = extractfield(RI,'re');


    function ret = iterate_over(thresh)
    
        nThresh = numel(thresh);
        ret = cell(1,nThresh);
        if exist('RI','var')
            old = extractfield(cell2mat(RI),'thresh');
        else
            old = [];    
        end

        idx = 1;
        for i = 1:nThresh

            threshold = thresh(i);

            I = find(old == threshold,1);
            if isempty(I)
                fprintf('(%d/%d)... ',i,nThresh);
                ret{idx} = compute_3D_Rand_error(affin,truth,mask,threshold);
                ret{idx}.thresh = threshold;
                fprintf('3D Rand error = %.4f @ %.2f\n',ret{idx}.re,threshold);
            else
                ret{idx} = RI{I};
            end
            idx = idx + 1;

        end

    end

end