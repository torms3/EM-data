function VI_score( fpath, template, samples, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'fpath',@(x)iscell(x));
    addRequired(p,'template',@(x)isstr(x));
    addRequired(p,'samples',@(x)isnumeric(x)&&all(x>=0));
    addOptional(p,'high',0.999,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'low',0.3,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'merge',true,@(x)islogical(x));
    addOptional(p,'thold',256,@(x)isnumeric(x)&&all(x>=0));
    addOptional(p,'arg',0.3,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'remap',false,@(x)islogical(x));
    addOptional(p,'overwrite',false,@(x)islogical(x));
    parse(p,fpath,template,samples,varargin{:});

    remap      = p.Results.remap;
    overwrite  = p.Results.overwrite;

    % watershed parameters
    args.iname = 'place_holder';
    args.oname = 'place_holder';
    args.isize = [];
    args.highv = 0.999;
    args.lowv  = 0.3;
    args.merge = p.Results.merge;
    args.thold = 256;
    args.farg1 = 0.3;
    args.lowt  = 256;

    % Piriform
    data  = load_Piriform_dataset(samples);

    % special case
    idx = samples == 2;
    if any(idx)
        affs = make_affinity(data{idx}.label);
        seg  = get_segmentation(affs(:,:,:,1),affs(:,:,:,2),affs(:,:,:,3));
        data{idx}.label = seg;
    end

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
                args.highv = high(j);
                for k = 1:numel(low)
                    args.lowv = low(k);
                    if args.merge
                        for l = 1:numel(thold)
                            args.thold = thold(l);
                            for m = 1:numel(arg)
                                args.farg1 = arg(m);
                                do_compute(samples(i),data{i}.label);
                            end
                        end
                    else
                        do_compute(samples(i),data{i}.label);
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
        if args.merge
            oname = [oname '_size' num2str(args.thold)];
            oname = [oname '_arg' num2str(args.farg1)];
        end
	    args.iname = [pwd '/' fname '.affin'];
        if remap
            oname = [oname '_u'];
            args.iname = [pwd '/' fname '.uaffin'];
        end
        args.oname = [pwd '/' oname];
        args.isize = import_size(fname,3);

        % run watershed only if no prior segmentation exists
        if exist([oname '.segment'],'file') == 2
            if ~overwrite; return; end;
        else
            run_watershed(args);
        end

        % load segmentation
        seg = import_volume(oname, args.isize, 'segment', 'uint32');

        % load merge tree
        mt = load_merge_tree(oname);

        % optimize VI score
        result.WS = args;
        result.VI = optimize_VI_score(seg, gt_seg, mt);

        % if exist, update
        update_result([oname '.mat'], result);

    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function update_result( fname, update )

    if exist(fname,'file')
        load(fname);
        fields = fieldnames(update);
        for i = 1:numel(fields)
            field = fields{i};
            result.(field) = update.(field);
        end
    else
        result = update;
    end

    save(fname,'result');

end
