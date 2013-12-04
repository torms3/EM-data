function [prob,prob_medfilt] = generate_prob_map( fwdImg, outIdx, filtrad )

	assert(ndims(fwdImg{1}) == 3);

	if( ~exist('filtrad','var'))
		filtrad = 4;
	end

	% softmax
	fwdImg = cellfun(@exp,fwdImg,'UniformOutput',false);
	prob = fwdImg{outIdx}./sum(cat(4,fwdImg{:}),4);

	% median filtering
	if( filtrad > 0 )
		[prob_medfilt] = medfilt3( prob, filtrad );
	end

end