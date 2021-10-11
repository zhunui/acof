clc,clear
close all
%---------------------------------------------------input------------------------------------------------%
path(path,'CoOccurFilter-master')
tic
for xunhuan =9:9
str1 = strcat ('./pair1/MRI-00', int2str(xunhuan) , '.jpg') ; 
str2 = strcat ('./pair1/SPECT-00', int2str(xunhuan) , '.jpg') ;
% str1 = strcat ('/Users/zhurui/Documents/MATLAB/CoF_fusion/CoF_fusion_optimization/3fusion/00', int2str(xunhuan) , '12.bmp') ;
% str2 = strcat ('/Users/zhurui/Documents/MATLAB/CoF_fusion/CoF_fusion_optimization/3fusion/00', int2str(xunhuan) , '-3.jpg') ;
mri = imread(str1);
% ct = imread(str2);
func = imread(str2);
% spect = imread('SPECT-007.jpg');
%--------------------------------------------------fusion------------------------------------------------%
% mri = rgb2gray(mri);
% ct = rgb2gray(ct);
% func = func(:,:,1);
% fused = fusion(mri,ct);
% figure,imshow(mri,[]);
% figure,imshow(func,[]);
fusedfuc = fusionfunc(mri,func);
% str3= strcat ('./colorcof/cof2/MRISPECT', int2str(xunhuan) , '.bmp');
% imwrite(uint8(fusedfuc),str3);
end
toc