function [ret] = LED_mask( prob, truth, w, LED_thresh, cls_thresh );

	if ~exist('LED_thresh','var')
		LED_thresh = 0.5;
	end
	if ~exist('cls_thresh','var')
		cls_thresh = 0.5;
	end

	% crop the truth to fit the probability map
	[lbl] = adjust_border_effect(truth,prob);

	% boudnary (affinity) classification error
	% bmap = prob > cls_thresh;
	% err = xor(bmap,logical(lbl));

	% ret.err = double(err);
	% ret.poserr = double(err & ~logical(lbl));
	% ret.negerr = double(err & logical(lbl));

	% error density by convolution
	bmap = double(prob > cls_thresh);
	err = xor(bmap,logical(lbl));
	err = padarray(err,floor(w/2));
	F = ones(w)/prod(w);
	led = convn(err,F,'valid');

	ret.led = led > LED_thresh;
	ret.neglbl = ~logical(lbl);
	ret.posled = ret.led & ~logical(lbl);

end