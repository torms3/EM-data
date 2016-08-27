function data = load_Piriform_dataset( idx )

    if ~exist('idx','var'); idx = [];   end;
    if isempty(idx);        idx = 1:10; end;

    cur = pwd;
    cd('~/Data_local/datasets/piriform/');

    for i = 1:numel(idx)
        n = idx(i);
        disp(['load stack' num2str(n) '...']);
        data{i}.image = loadtiff(['stack' num2str(n) '-image.tif']);
        data{i}.label = loadtiff(['stack' num2str(n) '-label.tif']);
    end

    cd(cur);

end
