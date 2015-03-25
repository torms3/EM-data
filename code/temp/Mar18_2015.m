% batch

for i = 1:numel(batch)

    data = batch{i};

    % image
    % write_tif_image_stack(data.image, ['batch' num2str(i) '_image.tif']);

    % label
    % [clrmap] = interactive_multiplot(data.label,true);
    % write_tif_image_stack(data.label, ['batch' num2str(i) '_label.tif'], clrmap);

    % mask
    fname = ['batch' num2str(i) '_mask.tif'];
    write_tif_image_stack(data.mask,fname);

end