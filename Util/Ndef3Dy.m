function Dy=Ndef3Dy
Dy=@(U)NForwardDy(U);
end

function Duy=NForwardDy(U)
Size=size(U);
Duy(Size(1),:,:)=U(1,:,:)-U(end,:,:);
Duy(1:end-1,:,:)=diff(U,1,1);
end