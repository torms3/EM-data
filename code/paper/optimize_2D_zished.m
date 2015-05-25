function optimize_2D_zished( ipath, gpath )
    
    % zished path
    zished = '/data/home/kisuklee/Workbench/seung-lab/watershed/zi/watershed/bin/watershed';

    high = 0.99;
    low  = 0.3;
    sz   = 25;
    thld = 0.4;

    for high = 0.5:0.1:0.1
        disp(['high = ' num2str(high)]);
        run_zished;
    end

    function run_zished

        % arguments
        args = sprintf(' --ipath=%s --gpath=%s --high %.3f --low %.3f --size %d --thold %.3f', ...
                       ipath,gpath,high/1000,low/1000,sz,thold/1000);
        sysline = [zished args];
        disp(sysline);
        [~,cmdout] = system(sysline);
        disp(cmdout);

    end

end