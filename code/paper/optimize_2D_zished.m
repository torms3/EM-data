function optimize_2D_zished( ipath, gpath )
    
    % zished path
    basedir = '/data/home/kisuklee/Workbench/seung-lab/watershed/zi/watershed/';
    zished  = [basedir 'bin/watershed'];

    high = 0.999;
    low  = 0.300;
    sz   = 25;
    thld = 0.400;

    %% 1st pass
    % resolution = 0.1    
    disp(['1st pass...']);
    thresh = [low+0.1:0.1:0.9 0.99];
    [data] = iterate_over(thresh);


    function data = iterate_over(thresh)
        for i = 1:numel(thresh)
            data = run_zished(thresh(i),low,sz,thld);
        end
    end

    function data = run_zished(h,l,s,t)

        % arguments
        args = sprintf(' --ipath=%s --gpath=%s --high=%.3f --low=%.3f --size=%d --thold=%.3f', ...
                       ipath,gpath,h,l,s,t);
        sysline = [zished args];
        [~,cmdout] = system(sysline);
        disp(cmdout);
        data = textscan(cmdout,'Precision : %f\nRecall    : %f\nRand error: %f');
    end

end