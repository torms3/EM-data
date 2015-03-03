function [ret] = compute_3D_Rand_error( affin, truth, thresh )
    
    if ~exist('thresh','var');thresh = 0.5;end;

    % ground truth
    segA = get_segmentation(truth.x,truth.y,truth.z);    
    segA(~truth.mask) = 0;

    % proposed    
    segB = get_segmentation(affin.x,affin.y,affin.z,thresh);
    segB(~truth.mask) = 0;
    
    % 3D Rand index
    ret = SNEMI3D_metrics(segA,segB);

end