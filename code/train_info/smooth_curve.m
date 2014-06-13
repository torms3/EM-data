function [data] = smooth_curve( data, w )

	if( w > 0 )

		% smoothing(convolution) filter
		hw = floor(w/2);
		avgFilter = ones(w,1)/w;

		% smoothing
		data.iter = data.iter(1+hw:end-hw);
		data.err  = conv(data.err, avgFilter, 'valid');
		data.cls  = conv(data.cls, avgFilter, 'valid');

		minVal = min([numel(data.iter) ... 
					  numel(data.err)  ...
					  numel(data.cls)]);
		data.iter = data.iter(1:minVal);
		data.err  = data.err(1:minVal);
		data.cls  = data.cls(1:minVal);
	end

end