function [stack] = write_multivolume_slices_as_tif( fname, mulvol, slice, scale )

	assert(iscell(mulvol));
	for i = 2:numel(mulvol)
		assert(isequal(size(mulvol{i}),size(mulvol{1})));
	end

	if ~exist('scale','var')
		scale = [];
	end

	sz = size(mulvol{1});
	stack = zeros(sz(1),sz(2),numel(mulvol));

	for i = 1:numel(mulvol)

		disp(['Writing ' num2str(slice) 'th slice in volume ' num2str(i) '...']);
		stack(:,:,i) = mulvol{i}(:,:,slice);

		if ~isempty(scale)
			stack(:,:,i) = scaledata(stack(:,:,i),scale(1),scale(2));
		end
	end

	% if ~isempty(scale)
	% 	stack = scaledata(stack,scale(1),scale(2));
	% end

	write_tif_image_stack( stack, [fname '.z' num2str(slice) '.tif'] );

end