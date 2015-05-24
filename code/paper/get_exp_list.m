function list = get_exp_list()

    % index
    idx = 1;

    % base dir
    basedir = '~/Workbench/torms3/znn-release/experiments/Ashwin/2D_boundary/train23_test1/';

    % Base2D (unbalanced)
    list{idx}.path  = [basedir 'Base2D/unbalanced/iter_30K/output/'];
    list{idx}.str   = 'Base2D';
    list{idx}.lgnd  = 'Base2D';
    list{idx}.batch = [2 3 1];
    idx = idx + 1;

    % Base2D (balanced)
    list{idx}.path  = [basedir 'Base2D/balanced/iter_30K/output/'];
    list{idx}.str   = 'Base2D_bal';
    list{idx}.lgnd  = 'Base2D-bal';
    list{idx}.batch = [2 3 1];  
    idx = idx + 1;

    % Base2D-R
    list{idx}.path  = [basedir 'Base2D-R/pretrain/iter_30K/output/'];
    list{idx}.str   = 'Base2D_R';
    list{idx}.lgnd  = 'Base2D-R';
    list{idx}.batch = [2 3 1];  
    idx = idx + 1;

    % Hybrid
    list{idx}.path  = [basedir 'Hybrid/freeze/iter_30K/output/'];
    list{idx}.str   = 'Hybrid_freeze';
    list{idx}.lgnd  = 'Hybrid (freeze)';
    list{idx}.batch = [2 3 1];  
    idx = idx + 1;

    % Hybrid-R
    list{idx}.path  = [basedir 'Hybrid-R/Base2D/iter_30K/output/'];
    list{idx}.str   = 'Hybrid_R';
    list{idx}.lgnd  = 'Hybrid-R';
    list{idx}.batch = [2 3 1];  
    idx = idx + 1;

    % VD2D
    list{idx}.path  = [basedir 'VeryDeep2_w109/dropout/rebalanced/global/eta02_out150/iter_60K/output/'];
    list{idx}.str   = 'VD2D';
    list{idx}.lgnd  = 'VD2D';
    list{idx}.batch = [2 3 1];  
    idx = idx + 1;

end