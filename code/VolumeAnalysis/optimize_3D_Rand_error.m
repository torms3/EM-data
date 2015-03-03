function [ret] = optimize_3D_Rand_error( affin, truth, thresh )

    if ~exist('thresh','var')
        thresh = [0.001 0.1:0.1:0.9 0.999];
    end

    % iterate through varying thresholds
    nThresh = numel(thresh);
    RI = cell(1,nThresh);
    
    for i = 1:nThresh

        threshold = thresh(i);
        fprintf('(%d/%d)... ',i,nThresh);

        RI{i} = compute_3D_Rand_error(affin,truth,threshold);
        RI{i}.thresh = threshold;

        fprintf('2D Rand error = %.4f @ %.2f\n',RI{i}.re,threshold);

    end

    RI = cell2mat(RI);
    
    ret.thresh = extractfield(RI,'thresh');
    ret.prec   = extractfield(RI,'prec');
    ret.rec    = extractfield(RI,'rec');
    ret.re     = extractfield(RI,'re');

end