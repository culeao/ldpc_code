function[rx_wave,non_index]=gotoChannel(u,e)
% �����ŵ������������������
n = length(u);
rx_wave = u;
j = 1;
non_index = [];
for i=1:n
    if(rand(1) > e) % ��һ�����ʳ���
        continue;
    else
        non_index(j) = i;
        j = j+1;
        rx_wave(i) = -1;
    end
end
