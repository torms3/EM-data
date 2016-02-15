function reform_metric_result( rootdir )

    template = 'Piriform*_output_*.mat';
    list = rdir([rootdir '/**/' template]);

    for i = 1:numel(list)

        disp(list(i).name);
        old = load(list(i).name);

        % watershed parameters
        if isfield(old.result,'args')
            result.WS = old.result.args;
        end

        % Rand score
        if isfield(old.result,'rf')
            result.Rand.thresh = old.result.th;
            result.Rand.merge  = old.result.rm;
            result.Rand.split  = old.result.rs;
            result.Rand.score  = old.result.rf;
        end

        % VI score
        if isfield(old.result,'VI')
            result.VI = old.result.VI;
        end

        % overwirte
        save(list(i).name,'result');

    end

end