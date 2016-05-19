%EXAMPLE_SCRIPT_HUGE - demonstrates usage of segmentation code for a huge
%image
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

addpath apply-dnn


%% Read net
fprintf('Reading net...\n');

%net=readnet(fullfile('nets','net-65.nnt'));     % window size 65
net=readnet(fullfile('nets','net-95.nnt'));     % window size 95
%net=readnet(fullfile('../matlab-testnet/example_net_simple.nnt'));
%% Process image

% will automatically split image if too big
t=tic;
processHugeNeuronImageWithNet('0-t.tiff',net,1e6);  
ptime=toc(t);
fprintf('Processed slice in %g seconds\n',ptime);
