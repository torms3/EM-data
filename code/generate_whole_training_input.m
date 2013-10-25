function [data] = generate_whole_training_input( img, lbl, bb, msk, w, affinity )

	%% Argument validations
	%
	if( ~exist('affinity','var') )
		affinity = true;
	end


	%% Options
	%
	normalize = true;


	%% bb + mask = a mask for valid locations
	%
	xx = bb(1,:);
	yy = bb(2,:);
	zz = bb(3,:);
	
	idx = false(size(msk));
	idx(xx(1):xx(2),yy(1):yy(2),zz(1):zz(2)) = true;
	bbMask = msk & idx;


	%% Input normalization
	%
	% [kisuklee: TODO]  mean 0, var 1	
	if( normalize )
		% remove DC component
		DC = mean(img(:));
		img = img - DC;

		% unit variance
		img = img/std(img(:));
	end


	%% whole training input data
	%
	if( affinity )
		% image
		data.image = img(2:end-1,2:end-1,2:end-1);

		% affinity label
		[G] = generate_affinity_graph( lbl );
		label = cell(3,1);
		label{1} = G.x;
		label{2} = G.y;
		label{3} = G.z;
		data.label = label;

		% affinity mask
		[M] = generate_affinity_mask( bbMask );
		mask = cell(3,1);
		mask{1} = M.x;
		mask{2} = M.y;
		mask{3} = M.z;
		data.mask = mask;
	else
		% image		
		data.image = img;
		
		% label
		data.label = double(lbl ~= 0);

		% mask
		data.mask = bbMask;
	end


	%% Boundary mirroring & post-processing
	%
	if( w > 0 )
		data.image = mirrorImageBoundary( data.image, w );
		padSz = floor(w/2);
		for i = 1:numel(data.label)
			data.label{i} = padarray( data.label{i}, [padSz padSz padSz], 0 );
		end
		data.mask = padarray( data.mask, [padSz padSz padSz], false );
	end

end