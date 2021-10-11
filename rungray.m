clc,clear
close all
%---------------------------------------------------input------------------------------------------------%
path(path,'CoOccurFilter-master')
tic
for xunhuan = 11:11
str1= strcat ('./image fusion data/0', int2str(xunhuan) , '.jpg') ; 
str2= strcat ('./image fusion data/0', int2str(xunhuan) , '-2.jpg') ;

mri = imread(str1);
ct = imread(str2);
% spect = imread('SPECT-007.jpg');
%--------------------------------------------------fusion------------------------------------------------%
mri = rgb2gray(mri);
ct = rgb2gray(ct);
fused = fusion(mri,ct);
% str3= strcat ('./paper4a/fusion', int2str(xunhuan) , '.bmp');
% imwrite(uint8(fused),str3);
end
toc