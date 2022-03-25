function [fused_image] = fusionfunc(A,B)
%FUSIONFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
%A is mri B is functional image
img1 = A;
img2 = B;
img1 = img1(:,:,1);
img2_YUV=ConvertRGBtoYUV(img2);
img2_Y=img2_YUV(:,:,1);

[hei, wid] = size(img2_Y);

imgf_Y=fusion(img1,uint8(img2_Y)); 

imgf_YUV=zeros(hei,wid,3);

imgf_YUV(:,:,1)=imgf_Y;
imgf_YUV(:,:,2)=img2_YUV(:,:,2);
imgf_YUV(:,:,3)=img2_YUV(:,:,3);
imgf=ConvertYUVtoRGB(imgf_YUV);

fused_image=uint8(imgf);


end

