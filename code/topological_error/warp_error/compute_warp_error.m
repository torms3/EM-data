function [ret] = compute_warp_error( truth, proposal, thresh )

	%% Argument validation
	%
	if ~exist('thresh','var')
		thresh = 0.5;
	end

	% adjust the size of the ground truth segmentation
	[cropped] = adjust_border_effect( truth, proposal );

	% compute rand error
	ret.segA = cropped;
	ret.segB = proposal;	
	mask=true(size(proposal));
	[warping_error, warped_labels, nonsimple_classify] ...
		= warping_error(cropped, proposal, mask, thresh);

	ret.err = warping_error;

end