function [] = process_feature_maps( fname, map_name, nmap, slice )

	if ~exist('slice','var')
		slice = 1;
	end
	
	slices = cell(1,nmap);

	parfor i = 1:nmap

		disp(['Processing feature map ' num2str(i) '...']);

		% load feature map
		map_fname = [fname '.' num2str(i-1)];
		[map] = import_volume( map_fname );

		% process feature map
		stack = scaledata(map,0,1);
		slices{i} = stack(:,:,slice);

		write_tif_image_stack( stack, [fname '.' map_name '.' num2str(i) '.tif'] );

	end

	[X,Y] = size(slices{1});
	slice_stack = cell2mat(slices);
	slice_stack = reshape(slice_stack,X,Y,[]);
	write_tif_image_stack( slice_stack, [fname '.' map_name '.z' num2str(slice) '.tif'] );

end