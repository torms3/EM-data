title('');
set(gca,'XTick',[],'YTick',[]);
f = getframe(gca);
imwrite(f.cdata,fname,'png');