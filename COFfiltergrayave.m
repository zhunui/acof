function [ text,rres ] = COFfiltergrayave( img,hws )
%COFFILTER 此处显示有关此函数的摘要
%   此处显示详细说明

%   Distributed as part of the "Co-occurrence Filter" paper:
%   It is an academic code, distributed under the GNU GPL license:
%   http://www.gnu.org/copyleft/gpl.html
%  
%  
%   Version: 1.0
%   Date: March 27th, 2017
%   Roy Josef Jevnisek: Roy.J.Jevnisek@gmail.com


% Processing Parameters:
nBins   = 32;   % number of bins (for the quantization)  default 32 K-MEANS cluster number
hws     = 5;    % filter - half window size default 3

% Read Data:
im.rgb = img; 
im.lab = rgb2lab(im.rgb);
im.idx = quantize(im.rgb, nBins);  %原来的mask，用聚类后的结果 统计共生矩阵  结果为lab空间
im.sz  = size(im.rgb);

% Collect Co-occurrence Statistics:
pab = collectPab(double(img(:,:,1)), ones(im.sz(1:2)), nBins); %ones 生成全1矩阵
% pab = collectPab(im.rgb(:,:,1), ones(im.sz(1:2)), 256,f); %ones 生成全1矩阵
pmi = pab./( sum(pab).' * sum(pab) + eps ); %pointwise mutual information 点态互信息

% Smooth:  
% f = fspecial('gaussian',  hws, sqrt(2*sqrt(hws) + 1)); %生成6*6 的Gaussian matrix sigma=2 * sqrt(hws) + 1
% f = fspecial('gaussian',  hws, 0.5); 
ff = fspecial('average', [hws,hws]);

%%%%%
temp = coFilter(im.lab, im.idx, pmi, ff);
res = lab2rgb(temp);
%%%%%
% res = lab2rgb(coFilter(im.lab, im.idx, pmi, ff )) ;

% Visualize: 
% figure(1); imshow(im.rgb); title('input image');
source = im.rgb(:,:,1);
% figure(2); imshow(res); title('CoF smoothed image');
rres = 255.* res(:,:,1);
text = double(source)-rres;
% figure(3);imshow(text,[]);title('texture image');
end



