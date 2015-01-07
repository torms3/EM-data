function [saddle] = get_toy_saddle( bin )

	if ~exist('bin','var')
		bin = 0.01;
	end

	x = -2:bin:2;
	y = -2:bin:2;
	
	[X,Y] = meshgrid(x,y);

	Z = X.^2 - Y.^2;

	Z = scaledata(Z,0,1);

	surf(X,Y,Z);

	saddle = Z;

end