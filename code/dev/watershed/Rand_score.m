function Rand_score( fpath, template, samples, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'fpath',@(x)iscell(x));
    addRequired(p,'template',@(x)isstr(x));
    addRequired(p,'samples',@(x)isnumeric(x));
    addOptional(p,'high',0.999,@(x)isnumeric(x)&&(0<=x)&&(x<=1));
    addOptional(p,'low',0.3,@(x)isnumeric(x)&&(0<=x)&&(x<=1));
    addOptional(p,'thold',256,@(x)isnumeric(x)&&(x>=0));
    addOptional(p,'arg',0.3,@(x)isnumeric(x)&&(0<=x)&&(x<=1));
    addOptional(p,'overwrite',false,@(x)islogical(x));
    parse(p,fpath,template,samples,varargin{:});

    if ~iscell(fpath); fpath = {fpath}; end;

    % watershed parameters
    args.iname = 'place_holder';
    args.oname = 'place_holder';
    args.isize = [];
    args.lowv  = 0.3;
    args.farg1 = 0.3;
    args.highv = 0.999;
    args.thold = 256;
    args.lowt  = 256;

    % Piriform
    data  = load_Piriform_dataset(samples);

    % grid optimization
    high  = p.Results.high;
    low   = p.Results.low;
    thold = p.Results.thold;
    arg   = p.Results.arg;
    cur   = pwd;
    for p = 1:numel(fpath)
        if ~exist(fpath{p},'dir'); continue; end;
        cd(fpath{p});
        for i = 1:numel(samples)
            for j = 1:numel(high)
                for k = 1:numel(low)
                    for l = 1:numel(thold)
                        for m = 1:numel(arg)
                            args.highv = high(j);
                            args.lowv  = low(k);
                            args.thold = thold(l);
                            args.farg1 = arg(m);
                            do_compute(samples(i),data{i}.label);
                        end
                    end
                end
            end
        end
    end
    cd(cur);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function do_compute( sample, gt_seg )

        %% assume that we are in the right directory location.
        %
        % watershed parameters
        fname = sprintf(template, sample);
        oname = [fname '_high' num2str(args.highv)];
        oname = [oname '_low' num2str(args.lowv)];
        oname = [oname '_size' num2str(args.thold)];
        oname = [oname '_arg' num2str(args.farg1)];
        args.iname = [pwd '/' fname '.affin'];
        args.oname = [pwd '/' oname];
        args.isize = import_size(fname,3);

        if ~p.Results.overwrite && exist([oname '.segment'],'file') == 2
            return;
        end

        % watershed
        run_watershed(args);

        % load segmentation
        seg = import_volume(oname, args.isize, 'segment', 'uint32');

        % load merge tree
        mt = load_merge_tree(oname);

        % optimize Rand score & save
        result = optimize_Rand_score(seg, gt_seg, mt);
        result.args = args;
        save([oname '.mat'],'result');

    end

end