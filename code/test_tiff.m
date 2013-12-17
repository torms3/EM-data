


tagstruct.ImageLength = size(imgdata,1);
tagstruct.ImageWidth = size(imgdata,2);

tagstruct.Photometric = Tiff.Photometric.MinIsBlack;
tagstruct.BitsPerSample = 32;
tagstruct.SamplesPerPixel = 1;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tagstruct.SampleFormat = 3;

t.setTag(tagstruct);
t.write(imgdata(:,:,1));
t.close();
for z = 1:size(imgdata,3)	
	t = Tiff('myfile.tif','a');
	t.write(imgdata(:,:,z));
	t.close();
end

