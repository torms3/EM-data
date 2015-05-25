function outim=processHugeNeuronImageWithNet(im_fn,net,maxpixels)
%PROCESSHUGENEURONIMAGEWITHNET Process image with the given DNN
% This is a modification of the processimagewithnet script which is
% tailored to process huge neuron images.
%
% Differences are:
% - black areas are not processed
% - a tif file name must be used as input, then only relevant image parts
%   are loaded.  This tif file should be tiled.  Use the tifcp UNIX util
%   for converting to tiled tif.
% - script saves individual processed image parts.  Will not reprocess an
%   already processed image part.
%
% This script is not properly commented yet
%
% Syntax:  
%       processHugeNeuronImageWithNet(im_fn,net)
%       processHugeNeuronImageWithNet(im_fn,net,maxpixels)
%
% Inputs:
%       im_fn - Input image filename.  Must be a TIFF, possibly tiled
%       net - net to use for processing. Load with readnet.
%       maxpixels - maximum number of pixels to process images directly
%           without splitting.  Optional, defaults to 0.5e6, reduce if you
%           get out of memory errors, increase if you don't (for faster
%           processing).  Note that memory usage depends on the specific
%           network.
%
% Outputs:
%       None.  The script saves individual image parts as PNG files.
%
% Example:
%       TODO
%
% See also: readnet
%
% Authors: Alessandro Giusti and Dan Claudiu Cireșan
% Dalle Molle Institute for Artificial Intelligence (IDSIA)
% Lugano, Switzerland
%
% Contact: alessandrog@idsia.ch - dan@idsia.ch
%
% FOR RESEARCH USE ONLY, DO NOT REDISTRIBUTE
%
% Aug 2012; Last revision: 17-Aug-2012


%% Check image  (must be grayscale, does not support multiple channels)
imi=imfinfo(im_fn);
assert(imi.BitDepth==8);
assert(strcmp(imi.ColorType,'grayscale')>0);
assert(imi.MaxSampleValue==255);
assert(imi.MinSampleValue==  0);
imw=imi.Width;
imh=imi.Height;

if(~isfield(imi,'TileWidth'))
    warning('Input image does not appear to be a tiled TIFF: there may be out-of-memory problems when reading it if the file is huge. You can convert the tiff to tiled format using tiffcp -t src.tiff dst.tiff');
end

%% Compute amount of padding required to rows and columns
% check that input maps have a center (odd size)
assert(mod(net.layers(1).l.Mx,2)==1);
assert(mod(net.layers(1).l.My,2)==1);
padr=(net.layers(1).l.My-1)/2;
padc=(net.layers(1).l.Mx-1)/2;

%% Handle large images by splitting into parts
if(nargin<3)
    maxpixels=0.5e6;     % by default, split images with more than 500Kpixels
end

% Check if maxpixels at least allows us to process a 16x16 subimage
% (plus for padding)
if(maxpixels < padr*2*padc*2+4*4)
    error('maxpixels parameter is too low and/or network patches are too big');
end

% Check if maxpixels at least allows us to process a 100x100 subimage
% (accounting for padding)
if(maxpixels < padr*2*padc*2+100*100)
    warning('IDSIA:manysplits','maxpixels parameter is small, many splits will be likely needed');
end

% Decide how many parts are needed
pr=1; pc=1;    % parts in rows, parts in columns
while(1)
    partsz=[ceil(imh/pr)+padr*2 ...
            ceil(imw/pc)+padc*2];
    if(partsz(1)*partsz(2)<=maxpixels) 
        break;  % this splitting is enough
    end
    if(partsz(1)>=partsz(2))
        pr=pr+1;
    else
        pc=pc+1;
    end
end
fprintf('Image (%g rows %g cols) will be processed in %g x %g parts\n',imh,imw,pr,pc);


%% Create tmp output directory
outdir=[im_fn '-outputs'];
if(exist(outdir,'dir')>0)
    warning('Output directory already exists.  Picking where we left off');
else
    mkdir(outdir);
end

%% Check whether output image exists, and if so, give a warning
outim_fn=[im_fn '-output.tiff'];
if(exist(outim_fn,'file')>0)
    warning('Output image file already exists!  Processing anyway, and will overwrite.');
else
    mkdir(outdir);
end


%% Setup image parts
parts=[]; parti=1;
for pri=1:pr
    for pci=1:pc
        % row and column ranges of the input image which we'll process
        r1=floor(imh/pr*(pri-1))+1;
        r2=floor(imh/pr*(pri  ))  ;
        c1=floor(imw/pc*(pci-1))+1;
        c2=floor(imw/pc*(pci  ))  ;
        
        part_fn=fullfile(outdir,sprintf(...
            'outputpart_rows%06gto%06g_cols%06gto%06g.tiff',...
            r1,r2,c1,c2));
        
        % Keep track of parts
        parts(parti).ri=pri;
        parts(parti).ci=pci;
        parts(parti).r1=r1;
        parts(parti).r2=r2;
        parts(parti).c1=c1;
        parts(parti).c2=c2;
        parts(parti).fn=part_fn;
        parti=parti+1;
    end
end

%% Actually process all parts (parfor should be allowed)

% Preload the trasfer function for output gray values
pf=load(fullfile('nets','output_transfer_function.mat'),'pf');

parfor parti=1:length(parts)
        
        p=parts(parti);
        
        if(exist(p.fn,'file')>0)
            fprintf('Skipping part r%04gc%04g because output file %s already exists\n',...
                p.ri,p.ci,p.fn);
            continue;
        end

        % add padding
        rows=(p.r1-padr):(p.r2+padr);
        cols=(p.c1-padc):(p.c2+padc);

        % mirror out-of-image pixels
        rows(rows<1)=2-rows(rows<1);
        cols(cols<1)=2-cols(cols<1);
        rows(rows>imh)=imh-(rows(rows>imh)-imh);
        cols(cols>imw)=imw-(cols(cols>imw)-imw);
        % TODO: this won't be enough with very small input images
        
        % double-check that all pixels are now inside the image
        assert(all(rows>=1) && all(rows<=imh));
        assert(all(cols>=1) && all(cols<=imw));

        % actually read relevant image part
        fprintf('Reading subimage rows %g to %g, cols %g to %g\n',min(rows),max(rows),min(cols),max(cols));
        im=imread(im_fn,'PixelRegion',{[min(rows) max(rows)],[min(cols) max(cols)]});
        assert(size(im,1)==max(rows)-min(rows)+1);
        assert(size(im,2)==max(cols)-min(cols)+1);
        
        % rescale range of image part after reading & check values
        assert(min(im(:))>=0); 
        if(isa(im,'uint8'))
            im=single(im)/255*2-1;
        else
            assert(isa(im,'double')||isa(im,'single'));
            im=single(im)*2-1;
        end
        assert(max(im(:))<=1);
        assert(min(im(:))>=-1);
        assert(isa(im,'single'));
        
        % make image part to feed the network with
        % (mirrors borders where needed)
        pim=im(rows-min(rows)+1,cols-min(cols)+1,:);
        
        % compute the actual data which must be processed, excluding
        % padding pixels.  This corresponds 1:1 with network outputs.
        pim_actual=pim((padr+1):(end-padr),(padc+1):(end-padc));
        
        % check whether such actual data is all black (uint8 value 0).
        if(all(pim_actual(:)==-1)) % (uint8 value 0 has been reranged to -1).
            % If it is, avoid processing, output grayvalue 0.5 instead
            % (will be rescaled)
            fprintf(' Not processing this part because it is blank\n');
            pout=0.5.*ones(size(pim_actual,1),size(pim_actual,2),2,'single');
        else % else, actually process the image part
            if(1) % DO THE REAL THING
                pout=processImagePartWithNet(pim,net);
            else  % TRICK 4 fast debugging (replicates input image)
                pout=repmat(pim((padr+1):(end-padr),(padc+1):(end-padc)),[1 1 2]);
            end
        end
        
        % check sanity
        assert(size(pout,1)==(size(pim,1)-padr*2));
        assert(size(pout,2)==(size(pim,2)-padc*2));
        assert(size(pout,3)==2);    % TODO: this only supports binary outputs for the moment
        outpart=pout(:,:,2);
        assert(size(outpart,1)==p.r2-p.r1+1);
        assert(size(outpart,2)==p.c2-p.c1+1);
        
        % adjust gray values with output transfer function
        outpart=polyval(pf.pf,outpart);
        
        % save result
        imwrite(uint8(outpart*255),p.fn);
end

%% Reconstruct output image
fprintf('Assembling output file parts\n');

% sanity check
assert(imw==max([parts.c2]));
assert(imh==max([parts.r2]));
assert(min([parts.c1])==1);
assert(min([parts.r1])==1);

% assemble output image
try
    outim=zeros(imh,imw,'uint8');
    for i=1:length(parts)
        fprintf('Reading file %s...\n',parts(i).fn);
        outim(parts(i).r1:parts(i).r2,parts(i).c1:parts(i).c2)=...
            imread(parts(i).fn);
    end
    fprintf('Saving to file %s...\n',outim_fn);
    imwrite(outim,outim_fn);
    fprintf('Done\n');
catch e
    warning('Did not create composite output image because of an error below (out of memory maybe).  Leaving individual image parts in directory %s',outdir);
    disp('Problem follows:');
    disp(e.getReport);
    outim=[];
end

end % function
    
    

