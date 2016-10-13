function [ret] = process_google_affinity( fpath, oname )

  % Create tif stack.
  stack = create_tif_stack(fpath);

  % Convert to 4D affinity graph format.
  nz  = size(stack,3)/3;
  aff(:,:,:,1) = stack(:,:,1:nz);
  aff(:,:,:,2) = stack(:,:,nz+1:nz+nz);
  aff(:,:,:,3) = stack(:,:,end-nz+1:end);

  [X,Y,Z,W] = size(aff);

  % Crop.
  target  = [1024 1024 128];
  margin  = ([X Y Z] - target)/2;
  offset  = [1 1 1] + margin;
  cropped = crop_tensor(aff, offset, target);

  % Transpose.
  ret = permute(cropped, [2 1 3 4]);

  % Save.
  hdf5write(oname, '/main', ret);

end
