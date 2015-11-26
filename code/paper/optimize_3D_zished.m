function [ret1,ret2] = optimize_3D_zished( ipath, gpath )

    % zished path
    % basedir = '/data/home/kisuklee/Workbench/seung-lab/watershed/zi/watershed/';
    basedir = '/usr/people/kisuk/Workbench/seung-lab/zished/zi/watershed/';
    zished  = [basedir 'bin/watershed'];

    best.high = 0.999;
    best.low  = 0;
    best.thld = 0;

    %% optimizing high

    %% 1st pass
    % resolution = 0.1
    disp(['1st pass...']);
    thresh = [0.01 0.1:0.1:0.9 0.99];
    data   = iterate_over(thresh,'high',{});

    %% 2st pass
    % resolution = 0.05
    disp(['2nd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.('high');
    thresh = union(thresh,[pivot-0.05,pivot+0.05]);
    data   = iterate_over(thresh,'high',data);

    %% 3rd pass
    % resolution = 0.01
    disp(['3rd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.('high');
    thresh = union(thresh,pivot-0.05:0.01:pivot+0.05);
    data   = iterate_over(thresh,'high',data);


    %% optimizing low
    [~,I] = min(extractfield(cell2mat(data),'re'));
    best.high = data{I}.high;
    best.low  = data{I}.low;
    best.thld = data{I}.thld;

    %% 1st pass
    % resolution = 0.1
    disp(['1st pass...']);
    thresh = [0:0.1:data{I}.high-0.001];
    data   = iterate_over(thresh,'low',data);

    %% 2st pass
    % resolution = 0.05
    disp(['2nd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.('low');
    thresh = union(thresh,[max(pivot-0.05,0),min(pivot+0.05,best.high-0.001)]);
    data   = iterate_over(thresh,'low',data);

    %% 3rd pass
    % resolution = 0.01
    disp(['3rd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.('low');
    thresh = union(thresh,max(pivot-0.05,0):0.01:min(pivot+0.05,best.high-0.001));
    data   = iterate_over(thresh,'low',data);

    %% Return
    %
    data1 = cell2mat(data);

    ret1.high = extractfield(data1,'high');
    ret1.low  = extractfield(data1,'low');
    ret1.thld = extractfield(data1,'thld');
    ret1.prec = extractfield(data1,'prec');
    ret1.rec  = extractfield(data1,'rec');
    ret1.re   = extractfield(data1,'re');


    %% optimizing size threshold
    [~,I] = min(extractfield(cell2mat(data),'re'));
    best.high = data{I}.high;
    best.low  = data{I}.low;
    best.thld = data{I}.thld;

    %% 1st pass
    % resolution = 0.1
    disp(['1st pass...']);
    thresh = [best.thld:100:1000];
    data   = iterate_over(thresh,'thld',data);


    %% Return
    %
    data2 = cell2mat(data);

    ret2.high = extractfield(data2,'high');
    ret2.low  = extractfield(data2,'low');
    ret2.thld = extractfield(data2,'thld');
    ret2.prec = extractfield(data2,'prec');
    ret2.rec  = extractfield(data2,'rec');
    ret2.re   = extractfield(data2,'re');


    function data = iterate_over( thresh, name, data )

        nThresh = numel(thresh);
        if isempty(data)
            old = [];
        else
            old = extractfield(cell2mat(data),name);
        end

        for i = 1:nThresh

            threshold = thresh(i);
            if any(ismember(old,threshold))
                continue;
            end

            fprintf('(%d/%d)...%s=%f\n',i,nThresh,name,thresh(i));
            args = best;
            args.(name) = thresh(i);
            data{end+1} = run_zished(args);

        end

    end

    function ret = run_zished(args)

        % arguments
        sysargs = sprintf(' --ipath=%s --gpath=%s --high=%.3f --low=%.3f --thold=%.3f', ...
                       ipath,gpath,args.high,args.low,args.thld);
        sysline = [zished sysargs];
        [~,cmdout] = system(sysline);
        disp(cmdout);
        C = textscan(cmdout,'Precision : %f\nRecall    : %f\nRand error: %f');
        ret.high = args.high;
        ret.low  = args.low;
        ret.thld = args.thld;
        ret.prec = C{1};
        ret.rec  = C{2};
        ret.re   = C{3};
    end

end