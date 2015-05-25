function data = optimize_2D_zished( ipath, gpath )
    
    % zished path
    basedir = '/data/home/kisuklee/Workbench/seung-lab/watershed/zi/watershed/';
    zished  = [basedir 'bin/watershed'];

    high = 0.999;
    low  = 0.001;
    sz   = 25;

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
                fprintf('(%d/%d)...\n',i,nThresh);
                ret{idx} = run_zished(thresh(i),low,sz,min(low+0.1,thresh(i)));
            else
                ret{idx} = data{I};
            end
            idx = idx + 1;

        end

    end

    function ret = run_zished(h,l,s,t)

        % arguments
        args = sprintf(' --ipath=%s --gpath=%s --high=%.3f --low=%.3f --size=%d --thold=%.3f', ...
                       ipath,gpath,h,l,s,t);
        sysline = [zished args];
        [~,cmdout] = system(sysline);
        disp(cmdout);
        C = textscan(cmdout,'Precision : %f\nRecall    : %f\nRand error: %f');
        ret.high = h;
        ret.low  = l;
        ret.size = s;
        ret.thld = t;
        ret.prec = C{1};
        ret.rec  = C{2};
        ret.re   = C{3};
    end

end