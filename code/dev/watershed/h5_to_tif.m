function h5_to_tif( fname )

  aff = hdf5read([fname '.h5'], '/main');

  saveastiff(aff(:,:,:,1), [fname '_0.tif'] );
  saveastiff(aff(:,:,:,2), [fname '_1.tif'] );
  saveastiff(aff(:,:,:,3), [fname '_2.tif'] );

end
