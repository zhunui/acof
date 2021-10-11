function [ fused_image,mri_CoF_s,mri_high,ct_CoF_s,ct_high ] = fusioncof( A,B )


% Processing Parameters:
nBins   = 32;   % number of bins (for the quantization)
hws     = 3;    % filter - half window size

% Read Data:
im1.rgb = A; 
im1.lab = rgb2lab(im1.rgb);
im1.idx = quantize(im1.rgb, nBins);
im1.sz  = size(im1.rgb);

im2.rgb = B; 
im2.lab = rgb2lab(im2.rgb);
im2.idx = quantize(im2.rgb, nBins);
im2.sz  = size(im2.rgb);


% Collect Co-occurrence Statistics:
pab1 = collectPab(im1.idx, ones(im1.sz(1:2)), nBins); %ones 生成全1矩阵
pmi1 = pab1./( sum(pab1).' * sum(pab1) + eps ); %pointwise mutual information 点态互信息

pab2 = collectPab(im2.idx, ones(im2.sz(1:2)), nBins); %ones 生成全1矩阵
pmi2 = pab2./( sum(pab2).' * sum(pab2) + eps ); %pointwise mutual information 点态互信息

% Smooth:  
f = fspecial('gaussian', 2 * hws, 2 * sqrt(hws) + 1); %生成6*6 的Gaussian matrix sigma=2 * sqrt(hws) + 1
res1 = lab2rgb(coFilter(im1.lab, im1.idx, pmi1, f ) );
res2 = lab2rgb(coFilter(im2.lab, im2.idx, pmi2, f ) );

im1.rgb = res1; 
im1.lab = rgb2lab(im1.rgb);
im1.idx = quantize(im1.rgb, nBins);
im1.sz  = size(im1.rgb);

im2.rgb = res2; 
im2.lab = rgb2lab(im2.rgb);
im2.idx = quantize(im2.rgb, nBins);
im2.sz  = size(im2.rgb);


% Collect Co-occurrence Statistics:
pab1 = collectPab(im1.idx, ones(im1.sz(1:2)), nBins); %ones 生成全1矩阵
pmi1 = pab1./( sum(pab1).' * sum(pab1) + eps ); %pointwise mutual information 点态互信息

pab2 = collectPab(im2.idx, ones(im2.sz(1:2)), nBins); %ones 生成全1矩阵
pmi2 = pab2./( sum(pab2).' * sum(pab2) + eps ); %pointwise mutual information 点态互信息


res1 = lab2rgb(coFilter(im1.lab, im1.idx, pmi1, f ) );
res2 = lab2rgb(coFilter(im2.lab, im2.idx, pmi2, f ) );
% Visualize: 
% figure,imshow(im1.rgb); title('input image');
source1 = A(:,:,1);
% figure,imshow(res1); title('CoF smoothed image');
rres1 = res1(:,:,1);
text1 = double(source1)-255.*rres1;
% figure,imshow(text1,[]);title('texture image');

% figure,imshow(im2.rgb); title('input image');
source2 = B(:,:,1);
% figure,imshow(res2); title('CoF smoothed image');
rres2 = res2(:,:,1);
text2 = double(source2)-255.*rres2;
% figure,imshow(text2,[]);title('texture image');

Img_d_sf = texturel(text1,text2);
% figure,imshow(uint8(Img_d_sf),[]);title('fused Img\_d');
% mrid = uint8(double(mri)-l);
% ctd = uint8(double(ct)-ll);
% Img_d_sf = textures(ctd,mrid,sigma);
% figure,imshow(Img_d_sf,[]);title('fused Img\_s');
Img_b_f = 255*base(rres1,rres2);
% figure,imshow(Img_b_f,[]);title('fused Img\_b');
fused_image =Img_d_sf+Img_b_f;
figure,imshow(uint8(fused_image));title('fused Img');
end

