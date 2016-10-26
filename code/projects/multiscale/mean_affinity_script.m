function mean_affinity_script( fpath, template, samples, data, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'fpath',@(x)iscell(x));
    addRequired(p,'template',@(x)isstr(x));
    addRequired(p,'samples',@(x)isnumeric(x)&&all(x>=0));
    addRequired(p,'data',@(x)iscell(x));
    addOptional(p,'high',0.999,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'low',0.3,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'merge',true,@(x)islogical(x));
    addOptional(p,'thold',256,@(x)isnumeric(x)&&all(x>=0));
    addOptional(p,'lowt',256,@(x)isnumeric(x)&&all(x>=0));
    addOptional(p,'arg',0.3,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'remap',false,@(x)islogical(x));
    addOptional(p,'overwrite',false,@(x)islogical(x));
    parse(p,fpath,template,samples,data,varargin{:});
    remap = p.Results.remap;

    % Watershed params.
    WS.high = p.Results.high;
    WS.low  = p.Results.low;
    WS.size = p.Results.thold;
    WS.arg  = p.Results.arg;
    WS.dust = p.Results.lowt;

    for i = 1:numel(fpath)
        cd(fpath{i});

        for j = 1:numel(samples)
            sample = samples(j);
            if remap
                iname = [pwd '/' sprintf(template,sample) '_u.h5'];
            else
                iname = [pwd '/' sprintf(template,sample) '.h5'];
            end
            oname = [pwd '/' sprintf(template,sample) '_mean_affinity'];
            if exist([oname '.h5'], 'file') ~= 2
                disp(['mean affinity agglomeration: ' oname '.h5']);
                mean_affinity_agglomeration(iname, [oname '.h5'], WS);
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
