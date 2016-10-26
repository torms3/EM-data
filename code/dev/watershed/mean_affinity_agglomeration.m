function mean_affinity_agglomeration( iname, oname, param )

    % local base dir.
    local_base = '/usr/people/kisuk/Workbench_local/seung-lab';

    % Mean affinity agglomeration.
    mean_agg = [local_base '/spipe/mean_affinity.jl'];

    % Run.
    sysargs = [iname ' ' oname];
    sysargs = [sysargs ' ' num2str(param.high)];
    sysargs = [sysargs ' ' num2str(param.low) ];
    sysargs = [sysargs ' ' num2str(param.size)];
    sysargs = [sysargs ' ' num2str(param.arg) ];
    sysargs = [sysargs ' ' num2str(param.dust)];
    sysline = ['julia ' mean_agg ' ' sysargs  ];
    % disp(sysline);
    [~,cmdout] = system(sysline);
    disp(cmdout);

end
