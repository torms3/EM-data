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
	end

end