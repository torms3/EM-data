function [ret] = load_affinity_from_tif( fname )

	ret{1} = loadtiff([fname '.affin.x.tif']);
	ret{2} = loadtiff([fname '.affin.y.tif']);
	ret{3} = loadtiff([fname '.affin.z.tif']);

	ret{1} = scaledata(double(ret{1}),0,1);
	ret{2} = scaledata(double(ret{2}),0,1);
	ret{3} = scaledata(double(ret{3}),0,1);

end