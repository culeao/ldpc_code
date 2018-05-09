function [u,P,rearranged_cols]=ldpc_encode(s,H)
%             高斯消元
%如果高斯消元过程中进行了列交换，
%则只需记录列交换，并以相反次序对编码后的码字同样进行列交换即可。
%解码时先求出u，再进行列交换得到uu=[c | s]，后面部分即是想要的信息。

dim=size(H);
rows=dim(1);
cols=dim(2);

% 高斯消元
[P,rearranged_cols]=H2P(H);

% 由生成矩阵 生成 二进制源序列
c=P*s';
c=mod(c, 2);

%加上校验位后的总源序列，长度为n
u1=[c' s];
% 还原H2P中列交换的值
u=reorder_bits(u1,rearranged_cols);
