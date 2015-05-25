function optimize_2D_zished( ipath, gpath )
    
    % zished path
    basedir = '/data/home/kisuklee/Workbench/seung-lab/watershed/zi/watershed/';
    zished  = [basedir 'bin/watershed'];

    high = 999;
    low  = 300;
    sz   = 25;
    thld = 400;

    for high = 500:100:1000
        disp_param;
        run_zished;
    end

    function run_zished

        % arguments
        args = sprintf(' --ipath=%s --gpath=%s --high %.3f --low %.3f --size %d --thold %.3f', ...
                       ipath,gpath,high/1000,low/1000,sz,thld/1000);
        sysline = [zished args];
        [~,cmdout] = system(sysline);
        disp(cmdout);

    end

    function disp_param
        disp(['high = ' num2str(high/1000) ', low = ' num2str(low/1000) ...
        ', size = ' num2str(sz) ', thold = ' num2str(thld/1000)]);
    end

end