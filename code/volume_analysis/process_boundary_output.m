function [] = process_boundary_output( train_fname, test_fname )

	for i = 1:numel(train_fname)

		fname = train_fname{i};
		[train{i}] = assess_boundary_result_script( fname );
		write_tif_image_stack( train{i}.prob, ['train' num2str(i) '.prob.tif'] );
		write_tif_image_stack( train{i}.mprob, ['train' num2str(i) '.mprob.tif'] );
		% saveastiff( train{i}.prob, ['train' num2str(i) '.prob.tif'] );
		% saveastiff( train{i}.mprob, ['train' num2str(i) '.mprob.tif'] );

	end

	for i = 1:numel(test_fname)

		fname = test_fname{i};
		[test{i}] = assess_boundary_result_script( fname );
		write_tif_image_stack( test{i}.prob, ['test' num2str(i) '.prob.tif'] );
		write_tif_image_stack( test{i}.mprob, ['test' num2str(i) '.mprob.tif'] );
		% saveastiff( test{i}.prob, ['test' num2str(i) '.prob.tif'] );
		% saveastiff( test{i}.mprob, ['test' num2str(i) '.mprob.tif'] );

	end

end