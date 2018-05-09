function [u]= reorder_bits(c,rearranged_cols)
%进行列还原
rows=length(rearranged_cols);
for i=rows:-1:1
   if rearranged_cols(i)~=0
      temp=c(i);
      c(i)=c(rearranged_cols(i));
      c(rearranged_cols(i))=temp;
   end
end

u=c;
