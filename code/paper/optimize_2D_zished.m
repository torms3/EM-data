function optimize_2D_zished( ipath, gpath )
    
    % zished path
    basedir = '/data/home/kisuklee/Workbench/seung-lab/watershed/zi/watershed/';
    zished  = [basedir 'bin/watershed'];

    high = 999;
    low  = 300;
    sz   = 25;
    thld = 400;

    %% 1st pass
    % resolution = 0.1    
    disp(['1st pass...']);
    thresh = [0.01 0.1:0.1:0.9 0.99];
    [data] = iterate_over(thresh);


    function data = iterate_over(thresh)
        for i = 1:numel(thresh)
            data = run_zished(thresh(i),low,sz,thld);
        end
    end

    function data = run_zished(h,l,s,t)

        % arguments
        args = sprintf(' --ipath=%s --gpath=%s --high %.3f --low %.3f --size %d --thold %.3f', ...
                       ipath,gpath,h/1000,l/1000,s,t/1000);
        sysline = [zished args];
        [~,cmdout] = system(sysline);
        disp(cmdout);
        data = textscan(cmdout,'Precision : %f\nRecall    : %f\nRand error: %f');
    end

    function disp_param
        disp(['high = ' num2str(high/1000) ', low = ' num2str(low/1000) ...
        ', size = ' num2str(sz) ', thold = ' num2str(thld/1000)]);
    end

end