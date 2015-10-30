function [data] = smooth_curve( data, w, method )

	if ~exist('method','var');method = 'moving';end;

	if w > 0
		% smoothing
		filtered	= smooth(data.err, w, method);
		data.stderr = sqrt(smooth(data.err.^2, w, method) - filtered.^2);
		data.err  	= filtered;
		filtered	= smooth(data.cls, w, method);
		data.stdcls = sqrt(smooth(data.cls.^2, w, method) - filtered.^2);
		data.cls  	= filtered;

		% cutting leading and trailing edges
		if strcmp(method,'moving')
			hw  = floor(w/2);
			n	= numel(data.iter);
			idx = [1:hw n-hw+1:n];

			data.iter(idx) 	 = [];
			data.stderr(idx) = [];
			data.err(idx)  	 = [];
			data.stdcls(idx) = [];
			data.cls(idx) 	 = [];
			data.n = numel(data.iter);
		end
	end

end