function mean_affinity_agglomeration( iname, oname )

    % local base dir.
    local_base = '/usr/people/kisuk/Workbench_local/seung-lab';

    % Mean affinity agglomeration.
    mean_agg = [local_base '/spipe/mean_affinity.jl'];

    % Run.
    sysargs = [iname ' ' oname];
    sysline = ['julia ' mean_agg ' ' sysargs];
    % disp(sysline);
    [~,cmdout] = system(sysline);
    disp(cmdout);

end
