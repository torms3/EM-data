function [clrmap] = interactive_multiplot( data, coloring, clrStr, clrmap )

	%% Argument validation
	%	
	if( is_valid_volume_dataset(data) )
		imgCell = struct2cell(data);
	else
		if iscell(data)
			assert(numel(data)>0);
			imgCell = data;
		else
			switch ndims(data)
			case {2,3}
				imgCell = {data};
			case 4
				dims = size(data);
				imgCell = mat2cell(data,dims(1),dims(2),dims(3),ones(dims(4),1));
			otherwise

			end
		end
	end
	if( ~exist('coloring','var') ) 
		coloring = false(numel(imgCell),1);
	else		
		assert(numel(imgCell) == numel(coloring));
	end
	if( ~exist('clrStr','var') ) 
		for i = 1:numel(imgCell)
			clrStr{i} = 'gray';
		end
	end

	[ret] = extract_subplot_dim( imgCell );
	subx = ret.subx;
	suby = ret.suby;


	%% Option
	%
	global invert_display
	invert_display = false;
	

	%% Declare global variables
	%
	global z


	%% Figure
	%
	% scn = get(0,'ScreenSize');
	% margin = 60;
	% szWin = scn(4) - 2*margin;
	% figure('Position',[scn(3)/2 margin szWin szWin]);
	h = figure;
	if( invert_display )		
		set( gcf, 'Color', 'k' );
	end


	%% Coloring
	%
	for i = 1:numel(coloring)

		if( coloring(i) )
			nSeg = max(unique(imgCell{i})); disp(nSeg);
			if( ~exist('clrmap','var') )
				clrmap = rand(nSeg,3);
			end
			clrmap(1,:) = 0;
			clrmaps{i} = clrmap;
		else
			clrmaps{i} = [];
		end

	end


	%% Extract image stack metadata
	%	and display the first image
	%
	for i = 1:numel(imgCell)

		ax(i) = subplot(subx,suby,i);		
		[x,y,nImages] = size(imgCell{i});
		z = 1;		

		if( isempty(clrmaps{i}) )
			imagesc( imgCell{i}(:,:,z) );
			colormap( clrStr{i} );
		else
			image( imgCell{i}(:,:,z) );
			colormap( clrmaps{i} );			
		end

		freezeColors
		daspect([1 1 1]);
		if( invert_display )
			title( sprintf('z = %d',z), 'Color', 'w' );
		else
			title( sprintf('z = %d',z) );
		end

		if( invert_display )
			axis off;
		end

		if ( ~strcmp(clrStr{i},'gray') )
			% colorbar;
		end

	end

	%% Set KeyPressFcn
	%
	set( h, 'KeyPressFcn', @(obj,evt) moveZ( evt.Key, imgCell, clrmaps, clrStr ) );

end


function moveZ( key, imgCell, clrmaps, clrStr )

	[ret] = extract_subplot_dim( imgCell );
	subx = ret.subx;
	suby = ret.suby;

	global invert_display
	global z
	[x,y,nImages] = size(imgCell{1});

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

	for i = 1:numel(imgCell)

		ax(i) = subplot(subx,suby,i);

		if( isempty(clrmaps{i}) )
			imagesc( imgCell{i}(:,:,z) );
			colormap( clrStr{i} );			
		else			
			image( imgCell{i}(:,:,z) );
			colormap( clrmaps{i} );			
		end
		
		freezeColors
		daspect([1 1 1]);
		if( invert_display )
			title( sprintf('z = %d',z), 'Color', 'w' );
		else
			title( sprintf('z = %d',z) );
		end

		if( invert_display )
			axis off;
		end

		if ( ~strcmp(clrStr{i},'gray') )
			% colorbar;
		end

	end

end


function [ret] = extract_subplot_dim( imgCell )

	assert(iscell(imgCell));
	assert(numel(imgCell)>=1);

	subx = 1;
	suby = 1;	
	switch numel(imgCell)
	case 2
		suby = 2;
	case 3
		subx = 2;
		suby = 2;
	case 4
		subx = 2;
		suby = 2;
	case 5
		subx = 2;
		suby = 3;
	case 6
		subx = 2;
		suby = 3;
	% case 6
	% case 7
	% case 8
	end

	ret.subx = subx;
	ret.suby = suby;

end