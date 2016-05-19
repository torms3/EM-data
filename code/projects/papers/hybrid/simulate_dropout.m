function [] = simulate_dropout( vol, p )

	vol = scaledata(double(vol),0,1);
	vol = 1 - vol;
	idx = rand(size(vol)) < p;	
	vol(idx) = 0;
	volplay(vol);

end