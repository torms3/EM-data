function run_watershed( args )
%% args format
%
%   args.iname = '/path/to/affinity/graph';
%   args.oname = '/path/to/output';
%   args.isize = [x y z];
%   args.highv = 0.999;
%   args.lowv  = 0.3;
%   args.farg1 = 0.3;
%   args.thold = 256;
%   args.lowt  = 256;
%   args.merge = 1;
%

    % local base dir
    local_base = '/usr/people/kisuk/Workbench/seung-lab';

    % watershed executable
    watershed = [local_base '/watershed/code/bin/runWatershedFull'];

    % watershed parameters
    params = {};
    params{end+1} = ['--inputFile ' args.iname];
    params{end+1} = ['--xSize ' num2str(args.isize(1))];
    params{end+1} = ['--ySize ' num2str(args.isize(2))];
    params{end+1} = ['--zSize ' num2str(args.isize(3))];
    params{end+1} = ['--highv ' num2str(args.highv)];
    params{end+1} = ['--lowv ' num2str(args.lowv)];
    params{end+1} = ['--enableMerge ' num2str(args.merge)];
    params{end+1} = ['--funcArg1 ' num2str(args.farg1)];
    params{end+1} = ['--thold ' num2str(args.thold)];
    params{end+1} = ['--lowt ' num2str(args.lowt)];
    params{end+1} = ['--outFileSegment ' args.oname '.segment'];
    params{end+1} = ['--outFileDendPairs ' args.oname '.dend_pairs'];
    params{end+1} = ['--outFileDendValues ' args.oname '.dend_values'];

    sysargs = strjoin(params);

    % run watershed
    sysline = [watershed ' ' sysargs];
    % disp(sysline);
    [~,cmdout] = system(sysline);
    disp(cmdout);

end