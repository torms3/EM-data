function [] = process_affinity_output( train_fname, test_fname )

	for i = 1:numel(train_fname)

		fname = train_fname{i};
		[out] = import_multivolume( fname );
		write_tif_image_stack( out{1}, ['train' num2str(i) '.affin.x.tif'] );
		write_tif_image_stack( out{2}, ['train' num2str(i) '.affin.y.tif'] );
		write_tif_image_stack( out{3}, ['train' num2str(i) '.affin.z.tif'] );

	end

	for i = 1:numel(test_fname)

		fname = test_fname{i};
		[out] = import_multivolume( fname );
		write_tif_image_stack( out{1}, ['test' num2str(i) '.affin.x.tif'] );
		write_tif_image_stack( out{2}, ['test' num2str(i) '.affin.y.tif'] );
		write_tif_image_stack( out{3}, ['test' num2str(i) '.affin.z.tif'] );

	end

end