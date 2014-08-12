function [cropped] = adjust_border_effect( original, target, isSize )

	%% Argument validation
	%
	assert(ndims(original)==3);
	if ~exist('isSize','var')
		isSize = false;
	end
	if isSize
		assert(ndims(target)==2);
		assert(~any(size(original) < target));
		szTarget = target;
	else
		assert(ndims(target)==3);
		assert(~any(size(original) < size(target)));
		szTarget = size(target);
	end

	%% Adjust by cropping
	%
	if isequal(size(original),szTarget)
		cropped = original;
	else		
		szDiff = size(original) - szTarget;
		szDiff = floor(szDiff/2);
		offset = szDiff+1;
		% disp(size(offset));
		% disp(size(szTarget));
		cropped = original( offset(1):offset(1)+szTarget(1)-1, ...
							offset(2):offset(2)+szTarget(2)-1, ...
							offset(3):offset(3)+szTarget(3)-1 );
		assert(isequal(size(cropped),szTarget));
	end

end