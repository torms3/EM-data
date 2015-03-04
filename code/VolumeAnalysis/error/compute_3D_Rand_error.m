function [ret] = compute_3D_Rand_error( affin, truth, mask, thresh )

    if ~exist('mask','var');mask = [];      end;   
    if ~exist('thresh','var');thresh = 0.5; end;

    % ground truth
    segA = get_segmentation(truth.x,truth.y,truth.z);    
    if ~isempty(mask);segA(~mask) = 0;end;

    % proposed    
    segB = get_segmentation(affin.x,affin.y,affin.z,thresh);
    if ~isempty(mask);segB(~mask) = 0;end;
    
    % 3D Rand index
    ret = SNEMI3D_metrics(segA,segB);

end