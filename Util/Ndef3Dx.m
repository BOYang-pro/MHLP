function Dx=Ndef3Dx
Dx=@(U)NForwardDx(U);
end

function Dux=NForwardDx(U)
Size=size(U);
Dux(:,Size(2),:)=U(:,1,:)-U(:,end,:);
Dux(:,1:end-1,:)=diff(U,1,2);
end