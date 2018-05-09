function [decode_wave,uhat]=ldpc_decode(rx_wave,H,rearranged_cols,non_index)
% ����LDPC����
decode_wave = rx_wave;
dim=size(H);
rows=dim(1);
cols=dim(2);
while(1)
    count = 0;
    for j = 1:rows % ����ÿһ��
        int = find(H(j,:) == 1);% �ҵ������е���1�ĵ��index����������int��
        c=intersect(int,non_index);% �󽻼�����c��Ϊ������Ϊ-1�ĵ��index
        if(length(c) ~= 1)% ��-1�ĸ�������1��������޷��жϳ�λ��Ԫ�أ�����Ѱ����һ��
            count = count + 1;
            continue;
        else
            sum_row = 0;
            for k = int %��������Ϊ1�ĵ�
                if(k ~= c(1)) % ��δ֪Ԫ���⣬����������
                    sum_row = sum_row + decode_wave(k);
                end
            end
            decode_wave(c(1))= mod(sum_row,2); % ���δ֪Ԫ�ص�ֵ��������Ҫmod 2��������������
            non_index(non_index == c(1))=[]; % ��δ֪Ԫ������������ɾ����-1Ԫ��
        end
    end
    if(count == rows || isempty(non_index)) % ������ѭ������δ֪Ԫ�ؾ�δ����������Ѿ�ȫ�����ʱ���˳���ѭ�����������
        break;
    end
end
% �б任
uhat = extract_mesg(decode_wave,rearranged_cols);