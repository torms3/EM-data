%EXAMPLE_SCRIPT_HQ - demonstrates usage of segmentation code for obtaining
%high-quality probability maps (at added computational expense)
%
% Please refer to example_script.m for a properly commented introduction on
% the segmentation code usage.
%
% Authors: Alessandro Giusti and Dan Claudiu Cireșan
% Dalle Molle Institute for Artificial Intelligence (IDSIA)
% Lugano, Switzerland
%
% Contact: alessandrog@idsia.ch - dan@idsia.ch
%
% FOR RESEARCH USE ONLY, DO NOT REDISTRIBUTE
%
% May 2012; Last revision: 25-July-2012

addpath apply-dnn

%% Read source image
im=imread('neurons.png');
% note: im is expected to be uint8 grayscale (range [0-255]) or double
% grayscale (range [0-1]).


%% Process image
fprintf('Processing image...\n');
t=tic;

% Populate set of variations to compute
pars=[]; 
for netn={'net-65','net-95'}    % Which networks?
    for rotk=[0 1 2 3]          % Which rotations (multiples of 90deg)?
        for hmir={false true}   % Mirror?
            p=[];
            p.netn=netn{1};
            p.rotk=rotk;
            p.hmir=hmir{1};
            pars=[pars p];
        end
    end
end
fprintf('Computing a total of %g variations\n',length(pars));

% For each variation...
for pari=1:length(pars)
    fprintf('Computing variation %g of %g\n',pari,length(pars));
    p=pars(pari);
    
    % Transform input image according to variation
    iim=im;
    if(p.hmir) % Flip if needed
        iim=fliplr(iim); 
    end
    iim=rot90(iim,p.rotk);  % Rotate
    
    % Read appropriate net
    net=readnet(fullfile('nets',sprintf('%s.nnt',p.netn)));
    
    % Process trasformed image with appropriate net
    % will automatically split image if too big
    oim=processImageWithNet(iim,net);  
    % explicitly specify third parameter if you get out of memory errors
    % (defaults to 0.5e6).
    % out=processImageWithNet(im,net,0.2e6);  
    
    % Apply transfer function
    pf=load(fullfile('nets','output_transfer_function.mat'),'pf');
    oim=polyval(pf.pf,oim(:,:,2));
    
    % Transform back to original image coordinates
    oim=rot90(oim,-p.rotk);
    if(p.hmir)
        oim=fliplr(oim);
    end
    
    % Display result
    imshow(oim); drawnow;
    title(sprintf(...
        'Result of variation %g',pari));
    
    % Save to structure
    % TODO: would be best to save to file in case the input image is large
    out(pari).oim=oim;
    out(pari).p=p;
end

%% Average variations and postprocess

membrane_probabilities=mean(cat(3,out.oim),3);

% Prepare filtering kernels (disks of two different sizes)
dom1=fspecial('disk',3)>0.01; ord1=ceil(length(find(dom1))/2);
dom2=fspecial('disk',3)>0.03; ord2=ceil(length(find(dom2))/2);

% Define filtering function
ffunc=@(im) mean(cat(3,ordfilt2(im,ord1,dom1),ordfilt2(im,ord2,dom2)),3);

% Apply filtering function
membrane_probabilities_filtered=ffunc(membrane_probabilities);

% show image
close all;
cla;
imshow(membrane_probabilities_filtered);
title(sprintf(...
    'Membrane probabilities (average over %d variations) (filtered)',...
    length(pars)));
cbh=colorbar('YTick',linspace(0,1,6),'YTickLabels',1-linspace(0,1,6));

% save image
imwrite(membrane_probabilities_filtered,'neurons-probabilities-averaged-filtered.png');