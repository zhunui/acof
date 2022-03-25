clc,clear
close all
%---------------------------------------------------input------------------------------------------------%
path(path,'CoOccurFilter-master')
tic
for xunhuan = 10:10
str1= strcat ('./image fusion data/0', int2str(xunhuan) , '.jpg') ; 
str2= strcat ('./image fusion data/0', int2str(xunhuan) , '-2.jpg') ;

mri = imread(str1);
ct = imread(str2);
figure, imshow(mri,[]),title('mri');
figure, imshow(ct,[]),title('ct');
%--------------------------------------------------fusion------------------------------------------------%
mri = rgb2gray(mri);
ct = rgb2gray(ct);
fused = fusion(mri,ct);
figure, imshow(uint8(fused)),title('fused');

end
toc