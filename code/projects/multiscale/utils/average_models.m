function average_models( opath, fpath )
%% average over multiple models
%
    prefix   = 'Piriform';
    samples  = [1 2 3 9 10];
    lname    = 'output';
    lsize    = 1;
    zero_idx = 1; % 0 or 1

    template = [prefix '_sample%d_' lname '_%d'];

    for s = 1:numel(samples)
        sample = samples(s);
        disp(['Processing sample' num2str(sample) '...']);
        for idx = 1:lsize
            fname = sprintf(template,sample,idx-zero_idx);
            for m = 1:numel(fpath)
                cd(fpath{m});
                vols{m} = loadtiff([fname '.tif']);
            end
            avg = mean(cat(4,vols{:}),4);
            saveastiff(single(avg),[opath fname '.tif']);
        end
    end

    cd(opath);

end