function [fmaps] = feature_map( sample, lname )

    template = ['Piriform_sample' num2str(sample)];
    if exist('lname','var')
        template = [template '_' lname];
    end

    fmaps = containers.Map;
    flist = dir([pwd '/' template '*.tif']);
    names = extractfield(flist,'name');
    for i = 1:numel(flist)
        name = names{i};disp(name);
        name = name(1:end-4);
        pos  = findstr(name,'_');
        key  = name(pos(2)+1:pos(3)-1);
        num  = str2num(name(pos(3)+1:end));
        val  = {};
        if fmaps.isKey(key)
            val = fmaps(key);
        end
        val{num}   = loadtiff(names{i});
        fmaps(key) = val;
    end

    keys  = fmaps.keys;
    vals  = fmaps.values;
    for i = 1:numel(keys)
        v = vals{i};
        fmaps(keys{i}) = cat(4,v{:});
    end

end