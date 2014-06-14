function [medfilted] = medfilt3( stack, filtrad )

	switch ndims(stack)
	case 3
		parfor z = 1:size(stack,3)
			medfilted(:,:,z) = medfilt2(stack(:,:,z),[filtrad filtrad]);
		end
	case 2
		medfilted = medfilt2(stack,[filtrad filtrad]);
	otherwise
		disp(['Unacceptable volume dimension: ' num2str(ndims(stack))]);
		assert(false);
	end

end