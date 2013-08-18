function interactive_plot( imageStack, coloring )

	%% Argument validation
	%
	if( ~exist('coloring','var') ) 
		coloring = false;
	end

	% imageStack(imageStack ~= 0) = 1;

	%% Declare global variables
	%
	global images nImages h z
	images = imageStack;

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
	[w,h,nImages] = size(images);
	z = 1;
	if( coloring )
		image( images(:,:,z) );
	else	
		imagesc( images(:,:,z) );
	end
	daspect([1 1 1]);
	title( sprintf('z = %d',z) );
	h = imgcf;
	

	%% Set KeyPressFcn
	%
	set( h, 'KeyPressFcn', @(obj,evt) moveZ( evt.Key, coloring ) );

end


function moveZ( key, coloring )

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

	% image( images(:,:,z) );
	if( coloring )
		image( images(:,:,z) );
	else	
		imagesc( images(:,:,z) );
	end
	daspect([1 1 1]);
	title( sprintf('z = %d',z) );

end