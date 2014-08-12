function [] = process_boundary_output( train_fname, test_fname )

	for i = 1:numel(train_fname)

		fname = train_fname{i};
		[train{i}] = assess_boundary_result_script( fname );
		write_tif_image_stack( train{i}.prob, ['train' num2str(i) '.prob.tif'] );
		write_tif_image_stack( train{i}.mprob, ['train' num2str(i) '.mprob.tif'] );

	end

	for i = 1:numel(test_fname)

		fname = test_fname{i};
		[test{i}] = assess_boundary_result_script( fname );
		write_tif_image_stack( test{i}.prob, ['test' num2str(i) '.prob.tif'] );
		write_tif_image_stack( test{i}.mprob, ['test' num2str(i) '.mprob.tif'] );

	end

end

%% Version 1
%
% [out.train] = assess_boundary_result_script( fname1 );
% [out.test] 	= assess_boundary_result_script( fname2 );
%
% write_tif_image_stack( out.train.prob, 'train.prob.tif' );
% write_tif_image_stack( out.train.mprob, 'train.mprob.tif' );
% write_tif_image_stack( out.test.prob, 'test.prob.tif' );
% write_tif_image_stack( out.test.mprob, 'test.mprob.tif' );

%% Version 2
%
% function [] = process_boundary_output( in_name, out_name )	
%
% 	[ret] = assess_boundary_result_script( in_name );
% 	write_tif_image_stack( ret.prob, [out_name '.prob.tif'] );
% 	write_tif_image_stack( ret.mprob, [out_name '.mprob.tif'] );
%
% end