function [inputs,labels] = generate_training_input( img, lbl, bb, mask, dim )

	%% Argument validation
	%
	% Example
	%	5x5x5 input patches x 1000
	%	dim = [5 5 5 1000]	
	assert(isequal(size(dim),[1 4]));
	assert(dim(1) == dim(2));
	assert(dim(2) == dim(3));
	w = dim(1);
	v = floor(w/2);
	n = dim(4);
	m = floor(n/2);


	%% bb + mask = a mask for valid locations
	%
	yy = bb{:}(1,:);
	xx = bb{:}(2,:);
	zz = bb{:}(3,:);

	idx = false(size(mask{:}));
	idx(yy(1):yy(2),xx(1):xx(2),zz(1):zz(2)) = true;
	bbMask = mask{:} & idx;


	%% On-boundary voxels
	%
	onIdx = bbMask & (lbl{:} == 0);
	nOnVoxels = nnz(onIdx);
	linIdx = find(onIdx);
	[I,J,K] = ind2sub(size(onIdx),linIdx);
	randIdx = randperm(nOnVoxels);

	nOnSample = min(m,numel(randIdx));
	for i = 1:nOnSample

		j = randIdx(i);
		I(j) J(j) K(j)

	end

end