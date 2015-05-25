%EXAMPLE_SCRIPT - demonstrates usage of segmentation code
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

addpath apply-dnn

%% Read source image
im=imread('neurons.png');
% note: im is expected to be uint8 grayscale (range [0-255]) or double
% grayscale (range [0-1]).

%% Read net
fprintf('Reading net...\n');

%net=readnet(fullfile('nets','net-65.nnt'));     % window size 65
 net=readnet(fullfile('nets','net-95.nnt'));     % window size 95

%% Process image
fprintf('Processing image...\n');
t=tic;

% will automatically split image if too big
out=processImageWithNet(im,net);  
% explicitly specify third parameter if you get out of memory errors
% (defaults to 0.5e6).
% out=processImageWithNet(im,net,0.2e6);  

ptime=toc(t);
npx=size(out,1)*size(out,2);
fprintf('Processed %g pixels in %g seconds (%g px/s)\n',npx,ptime,npx/ptime);

%% Fix outputs
% Note that output size is the same as input size
assert(size(im,1)==size(out,1));
assert(size(im,2)==size(out,2));

% output has 2 channels, which sum to 1
% channel 1: membrane
% channel 2: background
% note: values can not be directly interpreted as probabilities because
% both labels were equally represented in the training set.
sums=sum(out,3);
assert(all(abs(sums(:)-1)<1e-5));

% we take channel 2 and apply a precomputed transfer function to correct
% for the above-mentioned bias.
membrane=out(:,:,2);
pf=load(fullfile('nets','output_transfer_function.mat'),'pf');
membrane_probabilities=polyval(pf.pf,membrane);

% show image
cla;
imshow(membrane_probabilities);
title('Membrane probabilities');
cbh=colorbar('YTick',linspace(0,1,6),'YTickLabels',1-linspace(0,1,6));

% save image
imwrite(membrane_probabilities,'neurons-probabilities.png');

%% do simple postprocessing

% Prepare filtering kernels (disks of two different sizes)
dom1=fspecial('disk',3)>0.01; ord1=ceil(length(find(dom1))/2);
dom2=fspecial('disk',3)>0.03; ord2=ceil(length(find(dom2))/2);

% Define filtering function
ffunc=@(im) mean(cat(3,ordfilt2(im,ord1,dom1),ordfilt2(im,ord2,dom2)),3);

% Apply filtering function
membrane_probabilities_filtered=ffunc(membrane_probabilities);

% show image
figure;
cla;
imshow(membrane_probabilities_filtered);
title('Membrane probabilities (filtered)');
cbh=colorbar('YTick',linspace(0,1,6),'YTickLabels',1-linspace(0,1,6));

% save image
imwrite(membrane_probabilities_filtered,'neurons-probabilities-filtered.png');