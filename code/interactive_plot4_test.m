function interactive_plot4_test( img1, img2, img3, img4, clrStr )

	%% Declare global variables
	%
	global images nImages h z
	images = cell(4,1);
	images{1} = img1;
	images{2} = img2;
	images{3} = img3;
	images{4} = img4;


	%% Figure
	%
	figure;
	colormap( clrStr );


	%% Extract image stack metadata
	%	and display the first image
	%	
	for i = 1:numel(images)

		subplot(2,2,i);
		[w,h,nImages] = size(images{i});
		z = 1;
		imagesc( images{i}(:,:,z) );
		daspect([1 1 1]);
		title( sprintf('z = %d',z) );

	end	
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

	for i = 1:numel(images)

		subplot(2,2,i);		
		imagesc( images{i}(:,:,z) );
		daspect([1 1 1]);
		title( sprintf('z = %d',z) );

	end

end