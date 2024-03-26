clc;
clear all;
close all;
data_path = 'dataset_draw.txt';
% dataset_draw.txt����˽ż�λ�ý�������ݼ���ÿһ�ж���һ�����������ݣ���һ��
% �ǲ�̫�ż��x�����꣬�ڶ����ǽż��y�����꣬��������z�������220�������220
% ����˼�������̫�ż�z��������247����ֻ���27��ʹ�ýż��x�ᡢy�ᡢz��������
% ֵ��С��࣬�Ӷ�����������ľ��ȣ����������ǵ���̫�ż⴦�ڸ�λ��ʱ��A���
% �ȣ������к͵�������ֱ���B���C��߶ȣ���λ���Ǻ���mm
%% ������
fid = fopen(data_path,'r');
data1 = cell2mat(textscan(fid,'%.4f'));
data1 = reshape(data1,[6 length(data1)/6]);
data1 = data1';
data1(:,3) = data1(:,3);
fclose(fid);
%% Ԥ��
pred_data1 = data1(:,1:3);
real_label1 = data1(:,4:6);
[pred_label1] = function_predict(pred_data1, 2);
[pred_label2] = function_predict_fpga(pred_data1,2);
%% ��ͼ
figure;
% չʾ���ݼ��ĸ��Ƿ�Χ���ǰ뾶Ϊ100mm��Բ��
scatter3(pred_data1(:,1),pred_data1(:,2),pred_data1(:,3));
axis([-150 150 -150 150 0 50]);
title('���ݼ����̫�ż�ķ�Χ');
figure;
% ��������ͼ����һ������Խ��˵���˶�����㾫��Խ��
scatter3(pred_label1(:,1),pred_label1(:,2),pred_label1(:,3));hold on;
scatter3(real_label1(:,1),real_label1(:,2),real_label1(:,3));hold on;
title('�����ֵ��ʵ�ʾ�ȷֵ�Ա�');
%% ����mse
mse = sqrt(mean((real_label1-pred_label1).^2))
mse = sqrt(mean((real_label1-pred_label2).^2))
%    0.1392    0.1088    0.1190 % �����������mse
%    0.2505    0.1941    0.2090 % FPGA���㻯�������mse
aaa = real_label1-pred_label1;
figure;
plot(aaa(:,1));hold on;
plot(aaa(:,2));hold on;
plot(aaa(:,3));hold on;

