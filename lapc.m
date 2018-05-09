clear all;
n=[100,1000,10000];
j=3;
k=6;
% e Ϊ�����ŵ�����Ŀ�����
e = 0:0.05:1;
for time = 1:length(n)
    tic
    if(mod(n(time),k) ~= 0)
        N(time) = n(time) - mod(n(time),k) + k;
    end
    m = N(time)*j/k;
    rows=m;
    cols=N(time);
    % Դ���У�����룩
    s=round(rand(1, cols-rows));
    % ���ɼ������ H
    H = genH(N(time),j,k);
    % ldpc���룬���ɾ���
    [u,P,rearranged_cols]=ldpc_encode(s,H);
    for i = 1:length(e)
        % �����ŵ�����֮�������
        [rx_wave,non_index] = gotoChannel(u,e(i));
        % LDPC ����
        [decode_wave,uhat]=ldpc_decode(rx_wave,H,rearranged_cols,non_index);
        % ���������
        errmax=find(s~=uhat);
        nerr=length(errmax);
        err_rate(i) = nerr/length(s);
    end
    figure;
    plot(e,err_rate); grid on;
    xlabel('erasure probability e');
    ylabel('error probability');
    title(['LDPC (3,6),n = ',num2str(n(time))]);
    toc
end

