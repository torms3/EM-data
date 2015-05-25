function out = processImageWithNet(im,net,maxpixels)
%PROCESSIMAGEWITHNET Process image with the given DNN
% Input image is automatically padded by mirroring in such a way that the
% output will be the same size as the input.
% In order to avoid out of memory errors, the code automatically splits
% large images in smaller parts for processing (and accounts for padding,
% which is automatically added to each part).
%
% Syntax:  
%       out = processImageWithNet(im,net)
%       out = processImageWithNet(im,net,maxpixels)
%
% Inputs:
%       im - Input image. Assumed 0-255 if uint8, 0-1 if single/double.
%            May have more than one channel, but that must match the number
%            of input maps to the provided net.
%       net - net to use for processing. Load with readnet.
%       maxpixels - maximum number of pixels to process images directly
%           without splitting.  Optional, defaults to 0.5e6, reduce if you
%           get out of memory errors, increase if you don't (for faster
%           processing).  Note that memory usage depends on the specific
%           network.
%
% Outputs:
%       out - Multichannel image, single precision floating point in [0-1]
%           range. One channel per output map.
%
% Example:
%       im=imread('neurons.png');
%       net=readnet(fullfile('nets','net-65.nnt');
%       out=processImageWithNet(im,net);
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
% May 2012; Last revision: 19-July-2012



%% Check sanity of inputs & condition image
assert(min(im(:))>=0);

% Rescale input data in [-1 1] range
if(isa(im,'uint8'))
    im=single(im)/255*2-1;
else
    assert(isa(im,'double')||isa(im,'single'));
    im=single(im)*2-1;
end
assert(max(im(:))<=1);
assert(min(im(:))>=-1);
assert(isa(im,'single'));

% Check that the input image has the correct number of channels
% (i.e. matching the net input maps)
assert(strcmp(net.layers(1).type,'input'));
assert(size(im,3)==net.layers(1).l.nMaps);

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
    partsz=[ceil(size(im,1)/pr)+padr*2 ...
            ceil(size(im,2)/pc)+padc*2];
    if(partsz(1)*partsz(2)<=maxpixels) 
        break;  % this splitting is enough
    end
    if(partsz(1)>=partsz(2))
        pr=pr+1;
    else
        pc=pc+1;
    end
end
fprintf('Image (%g rows %g cols) will be processed in %g x %g parts\n',size(im,1),size(im,2),pr,pc);

%% Prepare output data structure
assert(net.layers(end).l.Mx==1);
assert(net.layers(end).l.My==1);
out=nan(size(im,1),size(im,2),net.layers(end).l.nNeurons);

show=out(:,:,1);
show(isnan(show))=0.5;
imshow(show); drawnow;

%% Process all parts
for pri=1:pr
    for pci=1:pc
        % row and column ranges of the input image which we'll process
        r1=floor(size(im,1)/pr*(pri-1))+1;
        r2=floor(size(im,1)/pr*(pri  ))  ;
        c1=floor(size(im,2)/pc*(pci-1))+1;
        c2=floor(size(im,2)/pc*(pci  ))  ;

        % add padding
        rows=(r1-padr):(r2+padr);
        cols=(c1-padc):(c2+padc);

        % mirror out-of-image pixels
        rows(rows<1)=2-rows(rows<1);
        cols(cols<1)=2-cols(cols<1);
        rows(rows>size(im,1))=size(im,1)-(rows(rows>size(im,1))-size(im,1));
        cols(cols>size(im,2))=size(im,2)-(cols(cols>size(im,2))-size(im,2));
        % TODO: this won't be enough with very small input images
        
        % double-check that all pixels are now inside the image
        assert(all(rows>=1) && all(rows<=size(im,1)));
        assert(all(cols>=1) && all(cols<=size(im,2)));

        % make image part, process it and double-check output size
        pim=im(rows,cols,:);
        pout=processImagePartWithNet(pim,net);
        assert(size(pout,1)==(size(pim,1)-padr*2));
        assert(size(pout,2)==(size(pim,2)-padc*2));
        assert(size(pout,3)==size(out,3));
        out(r1:r2,c1:c2,:)=pout;

        % show intermediate result
        show=out(:,:,1);
        show(isnan(show))=0.5;
        imshow(show); drawnow;
    end
end
end % function
    
    

