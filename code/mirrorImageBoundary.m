function [mirroredImg] = mirrorImageBoundary( img, halfW )

	[w,h] = size(img);
	mirroredImg = padarray( img, [halfW halfW], 0 );

	% North
	mirroredImg(1:halfW,1+halfW:halfW+w) = flipud(img(2:1+halfW,:));

	% South
	mirroredImg(halfW+h+1:end,1+halfW:halfW+w) = flipud(img(end-halfW:end-1,:));
	
	% West
	mirroredImg(:,1:halfW) = fliplr(mirroredImg(:,halfW+2:halfW+1+halfW));

	% East
	mirroredImg(:,halfW+w+1:end) = fliplr(mirroredImg(:,w:w+halfW-1));

end