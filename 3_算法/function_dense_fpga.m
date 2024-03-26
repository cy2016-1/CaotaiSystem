function [dense_oput, k] = function_dense_fpga(layer_in, coe_data, k, nin, nout, PE_NUM, FL_IN, FL_WE, relu)
  tiling = ceil(nout / PE_NUM);
  for i=1:tiling
      wnum = min((nout - (i-1)*PE_NUM), PE_NUM);
      if (mod(nin,2)==1)
          fin = [layer_in(1,1:nin) 0];
      else
          fin = layer_in(1,1:nin); % 输入神经元
      end
      rnum = ceil(nin/2);
      bias = coe_data(k,1:wnum);k=k+1; % 偏置参数
      coff = coe_data(k:k+rnum-1,1:PE_NUM+wnum);k=k+rnum; % 权重参数
      fout = bias * 2^FL_IN;
      for p=1:wnum
          for j=1:rnum
              fout(p) = fout(p) + fin(j*2-1) * coff(j,p) + fin(j*2) * coff(j,PE_NUM+p);
              if ((fout(p)>2^31-1) || (fout(p)<-2^31))
                  warning('value overflow in fout(p)');
              end
          end
      end
      dense_oput((i-1)*PE_NUM+1:(i-1)*PE_NUM+wnum) = fout;
  end
  for i=1:length(dense_oput)
      if ((dense_oput(i)<0) && (relu==1))
          dense_oput(i) = 0;
      else
          dense_oput(i) = floor(dense_oput(i) / 2^FL_WE);
          if ((dense_oput(i)>2^15-1) || (dense_oput(i)<-2^15))
              warning('value overflow in dens0_oput(i)');
          end
      end
  end
end
