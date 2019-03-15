
val=1e-3;
B=[];
for i=1:100
  str = strcat('step-',num2str(i),'.nonzero');
  s = dir(str);
  if s.bytes ~= 0
  A = dlmread(str);
  idx = A(:,3)>val; 					% Only amplitudes > val
  B = [B;A(idx,:)];						% Accumulate data from files
  end
  %disp(size(B))
end

[~,ir,ic] = unique(B(:,1:2),'rows');   	% Only unique q8,q21 coordinates
X=B(ir,:);

disp(size(X))
dlmwrite('out.dat',X,'delimiter',' ');					% Write to file
disp(strcat('sum of amplitudes = ',num2str(sum(X(:,3)))))
