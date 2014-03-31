function [cropped] = adjust_border_effect( original, target )

	%% Argument validation
	%
	assert(ndims(original)==3);
	assert(ndims(target)==3);
	assert(~any(size(original) < size(target)));

	%% Adjust by cropping
	%
	if isequal(size(original),size(target))
		cropped = original;
	else
		szTarget = size(target);
		szDiff = size(original) - szTarget;
		szDiff = floor(szDiff/2);
		offset = szDiff+1;
		% disp(size(offset));
		% disp(size(szTarget));
		cropped = original( offset(1):offset(1)+szTarget(1)-1, ...
							offset(2):offset(2)+szTarget(2)-1, ...
							offset(3):offset(3)+szTarget(3)-1 );
		assert(isequal(size(cropped),size(target)));
	end

end