function [ fusedtexturel ] = texturel(mritext2,cttext2)
%TEXTUREL 此处显示有关此函数的摘要
%   此处显示详细说明

m = size(mritext2,1);            
n = size(mritext2,2);
fusedtexturel = zeros(m,n);
f = fspecial('gaussian',[7 7], 1);
gaus_mri = imfilter(mritext2,f,'replicate');
gaus_ct = imfilter(cttext2,f,'replicate');
salient_mri = mritext2 - gaus_mri;
salient_ct = cttext2 - gaus_ct;
for i = 1:m
    for j = 1:n
        if abs(salient_mri(i,j))>=abs(salient_ct(i,j))
            fusedtexturel(i,j) = mritext2(i,j);
        else
            fusedtexturel(i,j) = cttext2(i,j);
        end
    end

end
            
end

