function vol = merge_outputs( template, range )

    vols = {};
    for i = 1:numel(range)
        idx = range(i);
        vols{i} = loadtiff(sprintf(template,idx));
    end
    vol = cat(3,vols{:});

end