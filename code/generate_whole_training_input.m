function [data] = generate_whole_training_input( img, lbl, bb, mask, w, affinity )

	%% Options
	%
	if( ~exist('affinity','var') )
		affinity = true;
	end

	%% bb + mask = a mask for valid locations
	%
	xx = bb{:}(1,:);
	yy = bb{:}(2,:);
	zz = bb{:}(3,:);
	
	idx = false(size(mask{:}));
	idx(xx(1):xx(2),yy(1):yy(2),zz(1):zz(2)) = true;
	bbMask = mask{:} & idx;


	%% Input normalization
	%
	% [kisuklee: TODO]  mean 0, var 1
	img = 2*(img - 0.5);


	%% whole training input data
	%
	if( affinity )
		% data.image = img(1:end-1,1:end-1,1:end-1);
		% data.mask  = bbMask(1:end-1,1:end-1,1:end-1);
		data.image = img(2:end,2:end,2:end);
		data.mask  = bbMask(2:end,2:end,2:end);
		% label
		[G] = generate_affinity_graph( lbl{:} );		
		label = cell(3,1);
		label{1} = G.x;
		label{2} = G.y;
		label{3} = G.z;
		data.label = label;
	else		
		data.image = img;
		data.mask  = bbMask;
		% label
		label = cell(1);
		label{1} = (lbl{:} ~= 0);
		data.label = label;
	end


	%% Boundary mirroring & post-processing
	%
	data.image = mirrorImageBoundary( data.image, w );
	padSz = floor(w/2);
	for i = 1:numel(data.label)
		data.label{i} = padarray( data.label{i}, [padSz padSz padSz], 0 );
	end
	data.mask = padarray( data.mask, [padSz padSz padSz], false );

end