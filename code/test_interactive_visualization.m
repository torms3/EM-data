function [] = test_interactive_visualization( vol )

	obj = interactive_display;
	
	ax = subplot;
	imagesc(vol(:,:,obj.z));
	daspect([1 1 1]);
	title( sprintf('z = %d',obj.z) );	

	% set(obj,'KeyPressFcn',@(obj,evt)moveZ( evt.Key,vol));

end

% function moveZ( key, imgCell, clrmaps, clrStr )

% end