function average_output_script

    % index
    idx = 1;

    % base dir
    basedir = '~/Workbench/torms3/znn-release/experiments/Ashwin/2D_boundary/train234_test1/';

    % VDHR-P3
    list{idx}.path = [basedir 'VDHR/P3/iter_60K/output/'];
    idx = idx + 1;

    % VDHR-P2
    list{idx}.path = [basedir 'VDHR/P2/iter_60K/output/'];
    idx = idx + 1;

    % VDHR-P1
    list{idx}.path = [basedir 'VDHR/P1/iter_60K/output/'];
    idx = idx + 1;

    for i = 1:numel(list)
        cd(list{i}.path);        
        out1{i} = import_volume('out1.1');
        out2{i} = import_volume('out2.1');
        out3{i} = import_volume('out3.1');
        out4{i} = import_volume('out4.1');
    end

    % VDHR-avg
    cd([basedir 'VDHR/avg/iter_60K/output/']);
    export_volume('out1.1',sum(cat(4,out1{:}),4)/3);
    export_volume('out2.1',sum(cat(4,out2{:}),4)/3);
    export_volume('out3.1',sum(cat(4,out3{:}),4)/3);
    export_volume('out4.1',sum(cat(4,out4{:}),4)/3);

end