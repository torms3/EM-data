function [G] = generate_affinity_graph( lbl )

	% assert 3D
	assert(numel(size(lbl))==3);
	lbl = int32(lbl);

	% B: ground truth boundary map
	B = (lbl == 0);


	%% x-axis
	% boundary-boundary affinity mask
	bbMask = B(1:end-1,:,:) & B(2:end,:,:);

	x = lbl(1:end-1,:,:) - lbl(2:end,:,:);
	bMap = (x ~= 0) | bbMask;

	x(bMap)  = 0;
	x(~bMap) = 1;
	x = x(:,2:end,2:end);


	%% y-axis
	% boundary-boundary affinity mask
	bbMask = B(:,1:end-1,:) & B(:,2:end,:);

	y = lbl(:,1:end-1,:) - lbl(:,2:end,:);
	bMap = (y ~= 0) | bbMask;

	y(bMap)  = 0;
	y(~bMap) = 1;
	y = y(2:end,:,2:end);


	%% z-axis
	% boundary-boundary affinity mask
	bbMask = B(:,:,1:end-1) & B(:,:,2:end);
	
	z = lbl(:,:,1:end-1) - lbl(:,:,2:end);
	bMap = (z ~= 0) | bbMask;

	z(bMap)  = 0;
	z(~bMap) = 1;
	z = z(2:end,2:end,:);


	%% Affinity graph
	% 
	G.x = double(x);
	G.y = double(y);
	G.z = double(z);

end