
[out.train] = import_multivolume( fname1 );
[out.test] 	= import_multivolume( fname2 );

write_tif_image_stack( out.train{1}, 'train.affin.x.tif' );
write_tif_image_stack( out.train{2}, 'train.affin.y.tif' );
write_tif_image_stack( out.train{3}, 'train.affin.z.tif' );
write_tif_image_stack( out.test{1}, 'test.affin.x.tif' );
write_tif_image_stack( out.test{2}, 'test.affin.y.tif' );
write_tif_image_stack( out.test{3}, 'test.affin.z.tif' );
