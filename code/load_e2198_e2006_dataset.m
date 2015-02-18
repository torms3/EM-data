num_batch = 14;

for i = 1:num_batch
    disp(['load batch ' num2str(i) '...']);
    batch{i}.image = import_volume(['batch' num2str(i)],[],'image');
    batch{i}.label = import_volume(['batch' num2str(i)],[],'label');
    batch{i}.mask  = import_volume_mask(['batch' num2str(i)],[],'mask');
end

clear i;
clear num_batch;