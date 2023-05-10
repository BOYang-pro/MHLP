%% ================================================================
% This is the demo code for 
% "Detail-Aware Near Infrared and Visible Fusion with Multi-Order Hyper-Laplacian  Priors"
%  by B. Yang, Z. Jiang, D. Pan,H. Yu,W. Gui,

% If you use this code, please cite the following paper:

% B. Yang, Z. Jiang, D. Pan,H. Yu,W. Gui,
% Detail-Aware Near Infrared and Visible Fusion with Multi-Order Hyper-Laplacian  Priors
% =========================================================================

clear;
clc;
close all;
addpath(genpath(pwd));

VI_ori=im2double(imread('./IR-VIS/VI/010005.jpg'));
NIR1=im2double(imread('./IR-VIS/IR/010005.jpg'));
NIR=NIR1(:,:,1);

VI= myrgb2yuv(VI_ori);
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
eta_1 =0.001;
eta_2=0.001;
eta_3 =0.0005;  
%The coefficient of the first-order difference
alpha1     = 0.05; %Artifacts will appear,so it can't be less than 0.05
alpha2     = 0.0005; 
%The coefficient of the second-order difference
r = 0.1;             
%The penalty coefficient  for second-order difference
lap_psi         = 5e-3;
judge=2;     %2:input is IR/VIS
tol=0.01;    %RelCha
Ga=2.7;      %Gamma correction
opts.alpha1     = alpha1; 
opts.alpha2     = alpha2; 
opts.r     = r; 
opts.lap_psi     = lap_psi; 
[~,~,L]  = size(VI1);
sz       = size(NIR);
Nways    = [sz, L];
opts.Nways  = Nways;
%  2:input is IR/VIS
opts.judge = judge;  
opts.tol    = tol;  
opts.beta2 = beta2;
opts.beta3 = beta3;
opts.eta_1 = eta_1;
opts.eta_2 = eta_2;
opts.eta_3 = eta_3;
opts.maxit = maxit;
opts.sz = sz;
opts.Ga=Ga;

%% The Fusion Algorithm


I_guide = VI_NIRfusionL12(VI1, NIR,opts);
VI2(:,:,1)=I_guide(:,:,1);
I_guide = myryuv2rgb(VI2);
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