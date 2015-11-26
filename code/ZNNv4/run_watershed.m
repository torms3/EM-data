function run_watershed()

    % local base dir
    cur = pwd;
    cd(get_project_root_path);
    cd('..');
    local_base = pwd;
    cd(cur);

    % watershed executable
    watershed = [local_base '/watershed/code/bin/runWatershedFull'];

    % arguments
    args.iname = [pwd '/test.affinity'];
    args.oname = [pwd '/test'];
    args.isize = [1024 1024 100];
    args.lowv  = 0.3;
    args.highv = 0.99;
    args.lowt  = 250;
    args.thold = 10;

    % run watershed
    sysargs = sprintf('%s %d %d %d %f %f %d %d', ...
                      iname, isize, lowv, highv, lowt, thold, ...
                      [oname '.segment'], [oname '.dend_pairs'], ...
                      [oname '.dend_values']);
    sysline = [watershed ' ' sysargs];
    disp(sysline);
    [~,cmdout] = system(sysline);
    disp(cmdout);

    function

end