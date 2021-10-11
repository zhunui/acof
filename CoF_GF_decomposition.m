function [S,Ic] = CoF_GF_decomposition(I,sigma_1)

% GF
% N = floor(3*sigma_1);
% sigma = sigma_1;
% 
% GaussianFilter = fspecial('gaussian',[2*N+1, 2*N+1],sigma_1);
% Ig = imfilter(I,GaussianFilter,'conv');

% CoF
params.sigma_s=sigma_1;  % 5
params.sigma_oc=sigma_1;  % 10
Ic = CoOcurFilter(I,params);
S = double(I)-Ic;
% L = Ic-Ig;
% B = Ig;


end

