function [pred_label] = function_predict_fpga(test_data,net_type)
FL_IN = 7; % 输入神经元的小数部分位宽
FL_WE = 12; % 神经网络参数的小数部分位宽
FL_OU = 7; % 输出神经元的小数部分位宽
test_data = floor(test_data * 2^FL_IN);
fid = fopen('para.coe','r');
sss = textscan(fid,'%s');
sss = sss{1,1};
fclose(fid);
PE_NUM = 16;
DEPTH = 512;
coe_data = zeros(DEPTH,PE_NUM*2);
for i=1:DEPTH
    hex_data = sss{i+5};
    for j=1:PE_NUM*2
        coe_data(i,j) = hex2dec(hex_data(j*4-3:j*4));
    end
end
coe_data(coe_data>=32768) = coe_data(coe_data>=32768) - 65536;
sss = size(test_data);
pred_label = zeros(sss);

for q=1:sss(1)
    if (net_type==2)
        k = 174;
        [dens0_oput, k] = function_dense_fpga(test_data(q,:), coe_data, k, 3, 64, PE_NUM, FL_IN, FL_WE, 1);
        [dens1_oput, k] = function_dense_fpga(dens0_oput, coe_data, k, 64, 64, PE_NUM, FL_IN, FL_WE, 1);
        [dens2_oput, k] = function_dense_fpga(dens1_oput, coe_data, k, 64, 64, PE_NUM, FL_IN, FL_WE, 1);
        [dens3_oput, ~] = function_dense_fpga(dens2_oput, coe_data, k, 64, 3, PE_NUM, FL_IN, FL_WE, 0);
        pred_label(q,:) = dens3_oput / 2^FL_OU;
    end
    if (net_type==1)
        k = 1;
        [dens0_oput, k] = function_dense_fpga(test_data(q,:), coe_data, k, 2, 64, PE_NUM, FL_IN, FL_WE, 1);
        [dens1_oput, k] = function_dense_fpga(dens0_oput, coe_data, k, 64, 64, PE_NUM, FL_IN, FL_WE, 1);
        [dens2_oput, ~] = function_dense_fpga(dens1_oput, coe_data, k, 64, 2, PE_NUM, FL_IN, FL_WE, 0);
        pred_label(q,:) = dens2_oput / 2^FL_OU;
    end
end
