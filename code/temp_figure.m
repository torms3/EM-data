
netList = {'Turaga Network (MALIS)','ZNN Twin Network'};
pxlErr = [0.0814,0.0290;0.0164,0.0155];
fScore = [0.6413,0.8742;0.8005,0.8063];


figure;	
hold on;
barweb(pxlErr,zeros(size(pxlErr)),...
	0.8,{'Thick','Thin'},...
	[],[],'Pixel Error',[],'y',...
	netList,[],'plot');
hold off;

figure;	
hold on;
barweb(fScore,zeros(size(fScore)),...
	0.8,{'Thick','Thin'},...
	[],[],'F-Score',[],'y',...
	netList,[],'plot');
hold off;