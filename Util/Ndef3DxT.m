function DxT=Ndef3DxT
DxT=@(U)NForwardDxT(U);
end

function Dux=NForwardDxT(U)
Size=size(U);
Dux(:,2:Size(2),:)=-diff(U,1,2);
Dux(:,1,:)=U(:,end,:)-U(:,1,:);
end