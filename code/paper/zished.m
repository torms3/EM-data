function ret = zished( ipath, gpath, args)

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