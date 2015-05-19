function [] = time_stamped_weight( fpath, idx )

	cd(fpath);

	% weight list
	wlist = dir('*.weight');
	for i = 1:numel(wlist)
		
		% file handle
		w = wlist(i);
		disp(['Processing ' w.name '...']);
		h = dir([w.name '.hist']);

		% load weight history
		fh = fopen(h.name,'r');
		assert(fh ~= -1);
		assert(mod(h.bytes,8) == 0);
		nh = h.bytes/8;
		wh = fread(fh,nh,'double');
		assert(numel(wh) == nh);

		% time-stamped weight
		fw = fopen(w.name,'w');
		assert(fw ~= -1);
		assert(mod(w.bytes,8) == 0);
		nw = w.bytes/8;
		head = nw*(idx-1) + 1;
		tail = nw*idx;
		assert(head >= 1);
		assert(tail <= nh);
		fwrite(fw,wh(head:tail),'double');

		% close
		fclose(fh);
		fclose(fw);

	end

end