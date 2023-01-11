function DyT=Ndef3DyT
DyT=@(U)NForwardDyT(U);
end


function Duy=NForwardDyT(U)
Size=size(U);
Duy(2:Size(1),:,:)=-diff(U,1,1);
Duy(1,:,:)=U(end,:,:)-U(1,:,:);
end