function[rx_wave,non_index]=gotoChannel(u,e)
% 经过信道，加入噪声后的序列
n = length(u);
rx_wave = u;
j = 1;
non_index = [];
for i=1:n
    if(rand(1) > e) % 以一定几率出错
        continue;
    else
        non_index(j) = i;
        j = j+1;
        rx_wave(i) = -1;
    end
end
