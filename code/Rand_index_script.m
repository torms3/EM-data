function [ret] = Rand_index_script( fname, truth, params )

	assert(numel(params) == 4);
	assert(~any(params < 0));
	assert(nnz(params==0) == 1);

	template = generate_watershed_fname( fname, params, '*' );
	listing = dir(template);
	names = extractfield(listing,'name');
	names = sort(names);

	template = generate_watershed_fname( fname, params, '%d' );
	x = zeros(1,numel(names));
	y = zeros(1,numel(names));
	for i = 1:numel(names)

		x(i) = sscanf(names{i},template);
		[ws] = hdf5read(names{i},'/main');
		[RI] = compute_Rand_error( truth, ws );
		y(i) = RI.err;

		disp(['Rand index = ' num2str(y(i)) ' @ ' num2str(x(i))]);

	end

	[ret.x,idx] = sort(x,'ascend');
	ret.y = y(idx);

end