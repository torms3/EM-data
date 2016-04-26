function mean_affinity_script()

    template = 'Piriform_sample%d_output';
    samples  = [9 10];
    data     = load_Piriform_dataset(samples);

    fpath = exp_info;
    for i = 1:numel(fpath)
        cd(fpath{i});

        for j = 1:numel(samples)
            sample = samples(j);
            iname  = [pwd '/' sprintf(template,sample) '.h5'];
            % oname  = [pwd '/' sprintf(template,sample) '_mean_affinity'];
            % oname  = [pwd '/' sprintf(template,sample) '_mean_affinity_low0'];
            oname  = [pwd '/' sprintf(template,sample) '_mean_affinity_nu'];
            if exist([oname '.h5'], 'file') ~= 2
                disp(['mean affinity agglomeration: ' oname '.h5']);
                mean_affinity_agglomeration(iname, [oname '.h5']);
            end
            [seg,mt]    = load_segmentation(oname);
            result.Rand = optimize_Rand_score(seg, data{j}.label, mt);
            result.VI   = optimize_VI_score(seg, data{j}.label, mt);

            % if exist, update
            update_result([oname '.mat'], result);
        end
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