function Rand_score( fpath, fname, samples )

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

    high  = [0.999];
    low   = [0.0];
    % thold = 2.^[8:16];
    thold = [4096];

    cur = pwd;
    for p = 1:numel(fpath)
        cd(fpath{p});
        for i = 1:numel(samples)
            for j = 1:numel(high)
                for k = 1:numel(low)
                    for l = 1:numel(thold)
                        args.highv = high(j);
                        args.lowv  = low(k);
                        args.thold = thold(l);
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
        oname = [oname '_size' num2str(args.thold)];
        oname = [oname '_arg' num2str(args.farg1)];
        args.iname = [pwd '/' fname '.affin'];
        args.oname = [pwd '/' oname];
        args.isize = import_size(fname,3);

        if exist([oname '.segment'],'file') == 2
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