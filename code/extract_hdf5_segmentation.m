function [data] = extract_hdf5_segmentation( fname, segIdx )

	[img] = import_forward_image( fname, segIdx );
	assert(numel(img) == 3);

	data = cat(4,img{1},img{2},img{3});

end