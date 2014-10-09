function [ret] = LED_mask( prob, truth, w, LED_thresh, cls_thresh )

	if ~exist('LED_thresh','var')
		LED_thresh = 0.5;
	end
	if ~exist('cls_thresh','var')
		cls_thresh = 0.5;
	end

	% crop the truth to fit the probability map
	[lbl] = adjust_border_effect( truth, prob );

	% boudnary (affinity) classification error
	bmap = prob > cls_thresh;
	err = double(xor(bmap,logical(lbl)));

	ret.err = err;

end