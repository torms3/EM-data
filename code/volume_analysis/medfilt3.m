function [medfilted] = medfilt3( stack, filtrad )

	assert(ndims(stack) == 3);
	parfor z = 1:size(stack,3)
		medfilted(:,:,z) = medfilt2(stack(:,:,z),[filtrad filtrad]);
	end

end