function [u,P,rearranged_cols]=ldpc_encode(s,H)
%             ��˹��Ԫ
%�����˹��Ԫ�����н������н�����
%��ֻ���¼�н����������෴����Ա���������ͬ�������н������ɡ�
%����ʱ�����u���ٽ����н����õ�uu=[c | s]�����沿�ּ�����Ҫ����Ϣ��

dim=size(H);
rows=dim(1);
cols=dim(2);

% ��˹��Ԫ
[P,rearranged_cols]=H2P(H);

% �����ɾ��� ���� ������Դ����
c=P*s';
c=mod(c, 2);

%����У��λ�����Դ���У�����Ϊn
u1=[c' s];
% ��ԭH2P���н�����ֵ
u=reorder_bits(u1,rearranged_cols);
