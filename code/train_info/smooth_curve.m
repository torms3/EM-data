function [data] = smooth_curve( data, w )

	if w > 0

		% smoothing(convolution) filter
		halfw 			= floor(w/2);
		avgFilter 	= ones(w,1)/w;

		% smoothing
		data.iter 	= data.iter(1+halfw:end-halfw);
		filtered		= conv(data.err, avgFilter, 'valid');		
		data.stderr = sqrt(conv(data.err.^2,avgFilter,'valid') - filtered.^2);
		data.err  	= filtered;
		filtered		= conv(data.cls, avgFilter, 'valid');
		data.stdcls = sqrt(conv(data.cls.^2,avgFilter,'valid') - filtered.^2);
		data.cls  	= filtered;
		

		minVal 			= min([numel(data.iter) numel(data.err) numel(data.cls)]);
		data.iter 	= data.iter(1:minVal);
		data.err  	= data.err(1:minVal);
		data.stderr = data.stderr(1:minVal);
		data.cls  	= data.cls(1:minVal);
		data.stdcls = data.stdcls(1:minVal);
		data.n 	  	= numel(data.iter);

	end

end