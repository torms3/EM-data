
[out.train] = assess_boundary_result_script( 'out1' );
[out.test] 	= assess_boundary_result_script( 'out2' );

write_tif_image_stack( out.train.prob, 'train.prob.tif' );
write_tif_image_stack( out.train.mprob, 'train.mprob.tif' );
write_tif_image_stack( out.test.prob, 'test.prob.tif' );
write_tif_image_stack( out.test.mprob, 'test.mprob.tif' );
