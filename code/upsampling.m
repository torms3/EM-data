function [ret] = upsampling( stack )

	sz = size(stack);
	ret = zeros(sz(1),sz(2),2*sz(3)-1);
	for z = 1:sz(3)-1

		ret(:,:,2*z-1) = stack(:,:,z);
		ret(:,:,2*z) = (stack(:,:,z)+stack(:,:,z+1))./2;

	end
	ret(:,:,end) = stack(:,:,end);

end