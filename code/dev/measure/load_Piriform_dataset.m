function data = load_Piriform_dataset( idx )

    if ~exist('idx','var'); idx = [];   end;
    if isempty(idx);        idx = 1:10; end;

    cur = pwd;
    cd('~/Data_local/datasets/piriform/');

    for i = 1:numel(idx)
        n = idx(i);
        disp(['load stack' num2str(n) '...']);
        data{i}.image = hdf5read(['stack' num2str(n) '-image.h5'],'/main');
        data{i}.label = hdf5read(['stack' num2str(n) '-label.h5'],'/main');
        % special case
        % if n == 2
        %     aff = make_affinity(data{i}.label);
        %     seg = get_segmentation(aff(:,:,:,1),aff(:,:,:,2),aff(:,:,:,3));
        %     data{i}.label = seg;
        % end
    end

    cd(cur);

end
