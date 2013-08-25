function [M] = generate_affinity_mask( mask )

	% assert 3D
	assert(numel(size(mask)) == 3);


	%% x-axis
	%
	x = mask(1:end-1,:,:) & mask(2:end,:,:);
	x = x(:,2:end,2:end);


	%% y-axis
	%
	y = mask(:,1:end-1,:) & mask(:,2:end,:);
	y = y(2:end,:,2:end);


	%% z-axis
	%
	z = mask(:,:,1:end-1) & mask(:,:,2:end);
	z = z(2:end,2:end,:);


	%% Affinity mask
	%
	M.x = x;
	M.y = y;
	M.z = z;

end