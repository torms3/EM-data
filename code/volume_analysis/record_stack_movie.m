function record_stack_movie( fname, imgStack, coloring )

	%% Argument validation
	%
	if( ~exist('coloring','var') ) 
		coloring = false;
	end

	%% Create AVI object
	%
	aviobj = avifile([fname '.avi'],'compression','None');

	%% Figure
	%
	fig = figure;
	if( coloring )
		nSeg = max(unique(imgStack)); disp(nSeg);
		clrmap = rand(nSeg,3);
		clrmap(1,:) = 0;
		colormap(clrmap);
	else
		colormap('gray');
	end

	%% Extract image stack metadata and display the first image
	%	
	[~,~,nImages] = size(imgStack);
	for z = 2:nImages

		if( coloring )
			image( imgStack(:,:,z) );
		else	
			imagesc( imgStack(:,:,z) );
		end
		daspect( [1 1 1] );
		title( sprintf('z = %d',z) );

		% record
		F = getframe(fig);
		aviobj = addframe(aviobj,F);

	end

	aviobj = close(aviobj);

end