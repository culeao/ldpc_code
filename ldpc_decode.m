function [decode_wave,uhat]=ldpc_decode(rx_wave,H,rearranged_cols,non_index)
% 进行LDPC解码
decode_wave = rx_wave;
dim=size(H);
rows=dim(1);
cols=dim(2);
while(1)
    count = 0;
    for j = 1:rows % 对于每一行
        int = find(H(j,:) == 1);% 找到该行中等于1的点的index，并保存在int中
        c=intersect(int,non_index);% 求交集，即c中为该行中为-1的点的index
        if(length(c) ~= 1)% 若-1的个数大于1，则该行无法判断出位置元素，继续寻找下一行
            count = count + 1;
            continue;
        else
            sum_row = 0;
            for k = int %对于所有为1的点
                if(k ~= c(1)) % 除未知元素外，对其进行求和
                    sum_row = sum_row + decode_wave(k);
                end
            end
            decode_wave(c(1))= mod(sum_row,2); % 求出未知元素的值，这里需要mod 2，即更新序列码
            non_index(non_index == c(1))=[]; % 从未知元素索引向量中删除该-1元素
        end
    end
    if(count == rows || isempty(non_index)) % 当本次循环所有未知元素均未解出，或者已经全部解出时，退出总循环，解码完毕
        break;
    end
end
% 列变换
uhat = extract_mesg(decode_wave,rearranged_cols);