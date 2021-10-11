function [I_l] = base(s1_l,s2_l)
%BASE 此处显示有关此函数的摘要
%   此处显示详细说明
s1_l = double(s1_l);
s2_l = double(s2_l);
r=3;
ker=ones(2*r+1,2*r+1)/((2*r+1)*(2*r+1));
AA1=imfilter(s1_l,ker);
AA2=imfilter(s2_l,ker);
map=AA1>AA2;
I_l=s1_l.*map+s2_l.*(~map);
end

