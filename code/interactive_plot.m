function interactive_plot( imageStack, colormapStr )

	% imageStack(imageStack ~= 0) = 1;

	%% Declare global variables
	%
	global images nImages h z
	images = imageStack;

	%% Figure
	%
	% h = figure;
	colormap( colormapStr );


	%% Extract image stack metadata
	%	and display the first image
	%	
	[w,h,nImages] = size(images);
	z = 1;
	imagesc( images(:,:,z) );
	daspect([1 1 1]);
	title( sprintf('z = %d',z) );
	h = imgcf;
	

	%% Set KeyPressFcn
	%
	set( h, 'KeyPressFcn', @(obj,evt) moveZ( evt.Key ) );

end


function moveZ( key )

	global images nImages h z

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

	% imagesc( images(:,:,z) );
	imagesc( images(:,:,z) );
	daspect([1 1 1]);
	title( sprintf('z = %d',z) );

end