function [ text,rres ] = COFfiltergraycolor( img )
%COFFILTERGRAYCOLOR 此处显示有关此函数的摘要
%   此处显示详细说明

% Processing Parameters:
nBins   = 32;   % number of bins (for the quantization)  default 32
hws     = 3;    % filter - half window size default 3

% Read Data:
im.rgb = img; 
im.lab = rgb2lab(im.rgb);
im.idx = quantize(im.rgb, nBins);
im.sz  = size(im.rgb);

% Collect Co-occurrence Statistics:
pab = collectPab(im.idx, ones(im.sz(1:2)), nBins); %ones 生成全1矩阵
pmi = pab./( sum(pab).' * sum(pab) + eps ); %pointwise mutual information 点态互信息

% Smooth:  
f = fspecial('gaussian', 2 * hws, 2 * sqrt(hws) + 1); %生成6*6 的Gaussian matrix sigma=2 * sqrt(hws) + 1
% res = lab2rgb(coFilter(im.lab, im.idx, pmi, f ) );
res = coFilter(im.lab, im.idx, pmi, f ) ;  %get filtered image in lab space
% Visualize: 
% figure(1); imshow(im.rgb); title('input image');

% figure(2); imshow(res); title('CoF smoothed image');

text = lab2rgb(im.lab-res);
rres = lab2rgb(res);

% figure(3);imshow(text,[]);title('texture image');
end





