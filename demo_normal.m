clear;
clc;
close all;
addpath(genpath(pwd));
%% if you want 
VI_ori=im2double(imread('./NIR-VIS/normal/VI/002.tiff'));
NIR1=im2double(imread('./NIR-VIS/normal/NIR/002.tiff'));
NIR=NIR1(:,:,1);
VI = myrgb2yuv(VI_ori);
VI1(:,:,1)=VI(:,:,1);
VI1(:,:,2)=VI(:,:,1);
VI1(:,:,3)=VI(:,:,1);
VI2 = myrgb2yuv(VI_ori);

%%  Initialization
maxit = 5;      %Number of iterations   
%Control smooth H
beta2 = 0.000001;     
beta3 = 0.0001;
% The penalty factor for H
eta_1 =0.0001;
eta_2=eta_1;
eta_3 =eta_1;  
%The coefficient of the first-order difference
alpha1     = 0.05; %Artifacts will appear,so it can't be less than 0.05
alpha2     = 0.0005; 
%The coefficient of the second-order difference
r = 10;             
%The penalty coefficient  for second-order difference
lap_psi         = 5e-3;


opts.alpha1     = alpha1; 
opts.alpha2     = alpha2; 
opts.r     = r; 
opts.lap_psi     = lap_psi; 
[~,~,L]  = size(VI1);
sz       = size(NIR);
Nways    = [sz, L];
opts.Nways  = Nways;
opts.judge = 0;  % 0: Input is foggy image, 1: input is low-light image
opts.tol    = 0.01;  %RelCha
opts.beta2 = beta2;
opts.beta3 = beta3;
opts.eta_1 = eta_1;
opts.eta_2 = eta_2;
opts.eta_3 = eta_3;
opts.maxit = maxit;
opts.sz = sz;


%% The Fusion Algorithm


I_guide1 = VI_NIRfusionL12(VI1, NIR,opts);
VI2(:,:,1)=I_guide1(:,:,1);
I_guide = myryuv2rgb(VI2);
%% Plotting
close all


figure;
imshow(I_guide);





function yuv = myrgb2yuv(image)
    image = double(image);
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);

    yuv(:,:,1) = 0.299.*R + 0.587.*G + 0.114.*B;
    yuv(:,:,2) = - 0.1687.*R - 0.3313.*G + 0.5.*B ;
    yuv(:,:,3) = 0.5.*R - 0.4187.*G - 0.0813.*B;
end

function RGB = myryuv2rgb(R)
    RGB(:,:,1)= R(:,:,1) + 1.14*R(:,:,3);  
    RGB(:,:,2)= R(:,:,1) - 0.39*R(:,:,2) - 0.58*R(:,:,3);   
    RGB(:,:,3)= R(:,:,1) + 2.03*R(:,:,2);
end
