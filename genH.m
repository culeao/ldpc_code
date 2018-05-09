function [H]=genH(n,j,k)
rows = round(n*j/k);
cols = n;
parity_check=zeros(round(n/k),cols);
%%%%%%%%使每行随机产生k个1即行重为k%%%%%%%%%%%%%
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
%尝试删除4环
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
               chkfinish=0; %如果还存在4环，则不结束循环，还进入下一次循环
               common=common-1;
               if (round(rand)==0)           % 随机决定是保留前面的列还是后面的列
                  coltoberearranged=thecol;           %保留后面的列，交换前面的列
                  thecol=ones_position(j);
               else
                  coltoberearranged=ones_position(j); %保留前面的列，交换后面的列
               end
               parity_check(i,coltoberearranged)=3; %make this entry 3 so that we dont use
                                                    %of this entry again while getting rid
                                                    %of other cylces
               newrow=unidrnd(rows);
               iteration=0;     %尝试5次在待交换的列中随机查找0
               while parity_check(newrow,coltoberearranged)~=0 && iteration<5
                  newrow=unidrnd(rows);
                  iteration=iteration+1;
               end
               if iteration>=5  %超过5次后则扩大范围随机查找非1的0或3，直到找到为止
                  while parity_check(newrow,coltoberearranged)==1
                     newrow=unidrnd(rows);
                  end
               end
               %把该列中找到的0或3置为1
               parity_check(newrow,coltoberearranged)=1;
            end%if common==2
         end%for j=1:ones_count
      end%for i=[1:r-1 r+1:rows]
   end%for r=1:rows

   %如果本次循环已不存在4环，则结束循环，不进入下一次循环
   if chkfinish
      break
   end
end%for loop=1:10
parity_check=parity_check==1;
H = parity_check;

