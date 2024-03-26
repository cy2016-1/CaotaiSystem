function [pred_label] = function_predict(test_data,type)
if (2==type)
    filename = 'model_weights_draw.h5';
else
    filename = 'model_weights_angle.h5';
end
%% ¶ÁÈ¡²ÎÊı
dens0_bias = h5read(filename,'/dense/dense/bias:0');
dens0_wght = h5read(filename,'/dense/dense/kernel:0');
dens1_bias = h5read(filename,'/dense_1/dense_1/bias:0');
dens1_wght = h5read(filename,'/dense_1/dense_1/kernel:0');
dens2_bias = h5read(filename,'/dense_2/dense_2/bias:0');
dens2_wght = h5read(filename,'/dense_2/dense_2/kernel:0');
if (2==type)
    dens3_bias = h5read(filename,'/dense_3/dense_3/bias:0');
    dens3_wght = h5read(filename,'/dense_3/dense_3/kernel:0');
end
%% forward propagation
sss = size(test_data);
pred_label = zeros(sss);
for i=1:sss(1)
    dens0_oput = function_dense(test_data(i,:), dens0_wght, dens0_bias);
    dens0_oput(dens0_oput<0) = 0; % relu
    dens1_oput = function_dense(dens0_oput, dens1_wght, dens1_bias);
    dens1_oput(dens1_oput<0) = 0; % relu
    dens2_oput = function_dense(dens1_oput, dens2_wght, dens2_bias);
    if (2==type)
        dens2_oput(dens2_oput<0) = 0; % relu
        dens3_oput = function_dense(dens2_oput, dens3_wght, dens3_bias);
        pred_label(i,:) = dens3_oput';
    else
        pred_label(i,:) = dens2_oput';
    end
end
