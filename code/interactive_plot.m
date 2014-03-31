function interactive_plot( imageStack, coloring )

	%% Argument validation
	%
	if( ~exist('coloring','var') ) 
		coloring = false;
	end

	%% Options
	%
	RF.grid = true;
	RF.size = 25;


	% imageStack(imageStack ~= 0) = 1;
	if( (ndims(imageStack) == 4) & (size(imageStack,3) == 1) )
		imageStack = reshape(imageStack, size(imageStack,1), size(imageStack,2), []);
	end

	%% Declare global variables
	%
	global z
	images = imageStack;
	h = figure;

	%% Figure
	%
	% h = figure;
	if( coloring )
		nSeg = max(unique(imageStack)); disp(nSeg);
		clrmap = rand(nSeg,3);
		clrmap(1,:) = 0;
		colormap(clrmap);
	else
		colormap('gray');
	end


	%% Extract image stack metadata
	%	and display the first image
	%	
	[~,~,nImages] = size(images);
	z = 1;
	slice = images(:,:,z);
	if( coloring )		
		image( slice );
	else		
		imagesc( slice );
	end
	daspect( [1 1 1] );
	title( sprintf('z = %d',z) );
	

	%% Set KeyPressFcn
	%
	set( h, 'KeyPressFcn', @(obj,evt) moveZ( evt.Key, images, coloring ) );

end


function moveZ( key, images, coloring )

	global z
	[~,~,nImages] = size(images);

	switch key
	case 'uparrow'
		z = rem(z - 1,nImages);
		if( z == 0 )
			z = nImages;
		end
	case 'downarrow'
		z = rem(z + 1,nImages);
		if( z == 0 )
			z = nImages;
		end
	end

	slice = images(:,:,z);
	if( coloring )
		image( slice );
	else	
		imagesc( slice );
	end
	daspect([1 1 1]);
	title( sprintf('z = %d',z) );

end