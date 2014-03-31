function [] = assess_affinity_result( result, affin, mask )

	assert(isequal(size(affin),size(result)));
	assert(isequal(size(affin),size(mask)));
	
	fprintf('Now adjusting size difference...\n');
	szDiff = size(msk,1) - size(img{1},1);
	hSzDiff = floor(szDiff/2);
	G.x   = G.x(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);
	G.y   = G.y(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);
	G.z   = G.z(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);
	msk   = msk(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff);

end