function ret = optimize_2D_zished( ipath, gpath )
    
    % zished path
    basedir = '/data/home/kisuklee/Workbench/seung-lab/watershed/zi/watershed/';
    zished  = [basedir 'bin/watershed'];

    best.high = 0.999;
    best.low  = 0;    
    best.thld = 10;

    %% optimizing high
     
    %% 1st pass
    % resolution = 0.1    
    disp(['1st pass...']);
    thresh = [0.01 0.1:0.1:0.9 0.99];
    data   = iterate_over(thresh,'high');

    %% 2st pass
    % resolution = 0.05
    disp(['2nd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.('high');
    thresh = union(thresh,[pivot-0.05,pivot+0.05]);
    data   = iterate_over(thresh,'high');

    %% 3rd pass
    % resolution = 0.01
    disp(['3rd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.('high');
    thresh = union(thresh,pivot-0.05:0.01:pivot+0.05);
    data   = iterate_over(thresh,'high');


    %% optimizing low
    [~,I] = min(extractfield(cell2mat(data),'re'));
    best.high = data{I}.high;
    best.low  = data{I}.low;
    best.thld = data{I}.thld;

    %% 1st pass
    % resolution = 0.1    
    disp(['1st pass...']);
    thresh = [0:0.1:data{I}.high-0.001];
    data   = iterate_over(thresh,'low');

    %% 2st pass
    % resolution = 0.05
    disp(['2nd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.('low');
    thresh = union(thresh,[max(pivot-0.05,0),min(pivot+0.05,best.high-0.001)]);
    data   = iterate_over(thresh,'low');

    %% 3rd pass
    % resolution = 0.01
    disp(['3rd pass...']);
    [~,I]  = min(extractfield(cell2mat(data),'re'));
    pivot  = data{I}.('low');
    thresh = union(thresh,max(pivot-0.05,0):0.01:min(pivot+0.05,best.high-0.001));
    data   = iterate_over(thresh,'low');


    %% optimizing size threshold
    [~,I] = min(extractfield(cell2mat(data),'re'));
    best.high = data{I}.high;
    best.low  = data{I}.low;
    best.thld = data{I}.thld;

    %% 1st pass
    % resolution = 0.1    
    disp(['1st pass...']);
    thresh = [best.thld:10:100];
    data   = iterate_over(thresh,'thld');
    

    %% Return
    %
    data = cell2mat(data);
    
    ret.high = extractfield(data,'high');
    ret.low  = extractfield(data,'low');
    ret.thld = extractfield(data,'thld');
    ret.prec = extractfield(data,'prec');
    ret.rec  = extractfield(data,'rec');
    ret.re   = extractfield(data,'re');


    function ret = iterate_over(thresh,name)

        nThresh = numel(thresh);
        ret = cell(1,nThresh);
        if exist('data','var')
            old = extractfield(cell2mat(data),name);
        else
            old = [];    
        end

        idx = 1;
        for i = 1:nThresh

            threshold = thresh(i);

            I = find(old == threshold,1);
            if isempty(I)
                fprintf('(%d/%d)...%s=%f\n',i,nThresh,name,thresh(i));
                args = best;                
                args.(name) = thresh(i);
                args.thld = min(args.low+0.1,args.high-0.001);
                ret{idx} = run_zished(args);
            else
                ret{idx} = data{I};
            end
            idx = idx + 1;

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