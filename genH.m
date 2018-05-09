function [H]=genH(n,j,k)
rows = round(n*j/k);
cols = n;
parity_check=zeros(round(n/k),cols);
%%%%%%%%ʹÿ���������k��1������Ϊk%%%%%%%%%%%%%
bits_per_col=k;
for i=1:round(n/k)
    for set1=1:bits_per_col
        if((i-1)*bits_per_col+set1>cols)
            continue;
        else
            parity_check(i,(i-1)*bits_per_col+set1)=1;
        end
    end
end
H = parity_check;
for submatrix_count = 1:j-1
    submatrix = zeros(round(n/k),cols);
    rand_col_index = randperm(cols);
    for i=1:cols
        submatrix(:,i)=parity_check(:,rand_col_index(i));
    end
    H = cat(1,H,submatrix);
end

parity_check = H;
%����ɾ��4��
for loop=1:10
   chkfinish=1;
   for r=1:rows
      ones_position=find(parity_check(r,:)==1);
      ones_count=length(ones_position);
      for i=[1:r-1 r+1:rows]
         common=0;
         for j=1:ones_count
            if parity_check(i,ones_position(j))==1
               common=common+1 ;
               if common==1
                  thecol=ones_position(j);
               end
            end
            if common==2
               chkfinish=0; %���������4�����򲻽���ѭ������������һ��ѭ��
               common=common-1;
               if (round(rand)==0)           % ��������Ǳ���ǰ����л��Ǻ������
                  coltoberearranged=thecol;           %����������У�����ǰ�����
                  thecol=ones_position(j);
               else
                  coltoberearranged=ones_position(j); %����ǰ����У������������
               end
               parity_check(i,coltoberearranged)=3; %make this entry 3 so that we dont use
                                                    %of this entry again while getting rid
                                                    %of other cylces
               newrow=unidrnd(rows);
               iteration=0;     %����5���ڴ������������������0
               while parity_check(newrow,coltoberearranged)~=0 && iteration<5
                  newrow=unidrnd(rows);
                  iteration=iteration+1;
               end
               if iteration>=5  %����5�κ�������Χ������ҷ�1��0��3��ֱ���ҵ�Ϊֹ
                  while parity_check(newrow,coltoberearranged)==1
                     newrow=unidrnd(rows);
                  end
               end
               %�Ѹ������ҵ���0��3��Ϊ1
               parity_check(newrow,coltoberearranged)=1;
            end%if common==2
         end%for j=1:ones_count
      end%for i=[1:r-1 r+1:rows]
   end%for r=1:rows

   %�������ѭ���Ѳ�����4���������ѭ������������һ��ѭ��
   if chkfinish
      break
   end
end%for loop=1:10
parity_check=parity_check==1;
H = parity_check;

