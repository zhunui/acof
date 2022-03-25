clc,clear
close all
%---------------------------------------------------input------------------------------------------------%
path(path,'CoOccurFilter-master')
tic
for xunhuan =9:9
str1 = strcat ('./pair1/MRI-00', int2str(xunhuan) , '.jpg') ; 
str2 = strcat ('./pair1/SPECT-00', int2str(xunhuan) , '.jpg') ;

mri = imread(str1);
func = imread(str2);

%--------------------------------------------------fusion------------------------------------------------%

% func = func(:,:,1);
% fused = fusion(mri,ct);
figure,imshow(mri,[]),title('mri');
figure,imshow(func,[]),title('func');
fusedfuc = fusionfunc(mri,func);
figure,imshow(fusedfuc,[]),title('fused');

end
toc