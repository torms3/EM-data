function h5_to_tif( fname, location )

  if ~exist('location','var'); location = 'main'; end;

  out = hdf5read([fname '.h5'], ['/' location]);

  for i = 1:size(out,4)
    saveastiff(out(:,:,:,i), [fname '_' num2str(i-1) '.tif'] );
  end

end
