
lbl = train.label;
img = train.image;
msk = false(size(img));

w = 95;
hw = floor(w/2);
msk(hw+1:end-hw,hw+1:end-hw,:) = true;

bIdx = find((lbl == 0) & msk);
[I,J,K] = ind2sub(size(lbl), bIdx);

patches = single(zeros(w,w,numel(bIdx)));
for i = 1:numel(bIdx)
	x = I(i);
	y = J(i);
	z = K(i);

	patches(:,:,i) = single(img(x-hw:x+hw,y-hw:y+hw,z));
end