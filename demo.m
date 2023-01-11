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
VI=im2double(imread('.\haze\VI\001.png'));
NIR1=im2double(imread('.\haze\NIR\001.png'));
NIR=NIR1(:,:,1);

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
[~,~,L]  = size(VI);
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


fused_image = VI_NIRfusion(VI, NIR,opts);

%% Plotting
close all


figure;
imshow(fused_image);
