function [prob,prob_medfilt] = generate_prob_map( fwdImg, outIdx, filtrad, appply_exp )

	if ~exist('appply_exp','var')
		appply_exp = false;
	end

	if( ~exist('filtrad','var'))
		filtrad = 5;
	end

	% softmax
	if appply_exp
		fwdImg = cellfun(@exp,fwdImg,'UniformOutput',false);
	end
	prob = fwdImg{outIdx}./sum(cat(4,fwdImg{:}),4);

	% median filtering
	if filtrad > 0
		[prob_medfilt] = medfilt3( prob, filtrad );
	end

end