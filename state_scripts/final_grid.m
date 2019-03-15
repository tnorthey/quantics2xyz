
B=[];
for i=1:8
  fname=strcat('state',num2str(i),'/out.dat');
  A=dlmread(fname);
  B = [B; A];
end

[~,ir,ic] = unique(B(:,1:2),'rows');   	% Only unique q8,q21 coordinates
X=B(ir,:);

disp(size(X))
dlmwrite('grid.dat',X(:,1:2),'delimiter',' ');					% Write to file
disp(strcat('sum of amplitudes = ',num2str(sum(X(:,3)))))
