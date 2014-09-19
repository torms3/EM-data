function [fname] = generate_watershed_fname( fname, params, wildcard )

	assert(numel(params) == 4);
	assert(~any(params < 0));

	fname = [fname '.'];

	% Th
	if params(1) > 0
		fname = [fname 'Th-' num2str(params(1)) '.'];
	else
		fname = [fname 'Th-' wildcard '.'];
	end

	% Tl
	if params(2) > 0
		fname = [fname 'Tl-' num2str(params(2)) '.'];
	else
		fname = [fname 'Tl-' wildcard '.'];
	end

	% Ts
	if params(3) > 0
		fname = [fname 'Ts-' num2str(params(3)) '.'];
	else
		fname = [fname 'Ts-' wildcard '.'];
	end

	% Te
	if params(4) > 0
		fname = [fname 'Te-' num2str(params(4)) '.'];
	else
		fname = [fname 'Te-' wildcard '.'];
	end
	
	fname = [fname 'segm.h5'];

end