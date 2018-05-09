function [u]= extract_mesg(c,rearranged_cols)
%�б任
rows=length(rearranged_cols);
for i=1:rows
   if rearranged_cols(i)~=0
      temp=c(i);
      c(i)=c(rearranged_cols(i));
      c(rearranged_cols(i))=temp;
   end
end
cols=length(c);
u=c(rows+1:cols);
