function [ret] = extract_zalis_debug_info( iter )

	[out] = import_multivolume_series( 'train.out', 1:iter );
	[grad] = import_multivolume_series( 'train.grad', 1:iter );
	[zalis] = import_multivolume_series( 'train.zalis', 1:iter );

	for i = 1:numel(grad)
		zgrad{i} = grad{i}.*zalis{i};
	end

	ret.out = out;
	ret.grad = grad;
	ret.zalis = zalis;
	ret.zgrad = zgrad;

end