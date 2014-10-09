function [prob,mprob] = generate_prob_map( fwdimg, outidx, filtrad, appply_exp )

	if ~exist('filtrad','var')
		filtrad = [];
	end
	if ~exist('appply_exp','var')
		appply_exp = false;
	end

	% load from file
	if isstr(fwdimg)
		[fwdimg] = import_multivolume(fwdimg);
	end

	% for softmax
	if appply_exp
		[fwdimg] = cellfun(@exp,fwdimg,'UniformOutput',false);
	end
	[prob] = fwdimg{outidx}./sum(cat(4,fwdimg{:}),4);

	% median filtering
	mprob = [];
	if( any(filtrad) )
		[mprob] = medfilt3( prob, filtrad );
	end

end