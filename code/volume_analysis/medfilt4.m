function [medfilted] = medfilt4( stack, filtrad )

	assert(ndims(stack) == 4);
	for t = 1:size(stack,4)
		medfilted(:,:,:,t) = medfilt3(stack(:,:,:,t), filtrad);
	end

end