function measure_affinity( fpath, prefix, samples, valid )

    template = [prefix '_sample%d_output'];

    params.high  = 0.999;
    params.low   = 0.0;
    params.thold = 2.^[8:16];
    params.arg   = 0.3;

    % validation
    fname = [prefix '_sample' num2str(valid) '_output'];
    v4out_to_affin(fname);

    low   = 0.0;
    thold = 2.^[8:16];
    Rand_score({fpath},template,valid,'low',low,'thold',thold,'overwrite',true);

    best_score = 0;
    for i = 1:numel(thold)
        result = [fname];
        result = [result '_high0.999'];
        result = [result '_low' num2str(low)];
        result = [result '_size' num2str(thold(i))];
        result = [result '_arg0.3'];
        load([result '.mat']);
        if max(result.Rand.score) > best_score
            best_score = max(result.Rand.score);
            best_idx = i;
        end
    end
    thold = thold(best_idx);

    % test
    samples = setdiff(samples,valid);
    for i = 1:numel(samples)
        sample = samples(i);
        fname = [prefix '_sample' num2str(sample '_output'];
        v4out_to_affin(fname);
        Rand_score({fpath},template,sample,'low',low,'thold',thold,'overwrite',true);
    end

end