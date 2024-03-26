clc;
clear all;
close all;
%% 读数据
fp = fopen('dataset_angle.txt','r');
dataset = cell2mat(textscan(fp,'%.4f'));
dataset = reshape(dataset,[4 length(dataset)/4]);
dataset = dataset';
% dataset_angle.txt存放了角度解算的数据集，每一行是一条单独的数据，第一列是
% 外倾角，第二列是旋转角，第三列是B点和A点高度之差，第四列是C点和A点高度之差，
% 角度的单位是度，高度差的单位是mm
%% 运动逆解算（神经网络）的输入是角度值，输出是BA高度差和BC高度差
pred_data1 = dataset(:,1:2); % pred_data1是角度值
[pred_label1] = function_predict(pred_data1, 1); % pred_label1是BA高度差和BC高度差
[pred_label2] = function_predict_fpga(pred_data1,1);
%% 画图
figure; % 这幅图展示了BA高度差和外倾角、旋转角之间的关系
% 把这两幅图画在一起，贴得越紧说明运动逆解算精度越高
scatter3(dataset(:,1),dataset(:,2),dataset(:,3));hold on; % 画数据集里的数据
scatter3(dataset(:,1),dataset(:,2),pred_label1(:,1));hold on; % 画逆解算的结果
xlabel('外倾角');
ylabel('旋转角');
zlabel('BA高度差');
figure; % 这幅图展示了CA高度差和外倾角、旋转角之间的关系
% 把这两幅图画在一起，贴得越紧说明运动逆解算精度越高
scatter3(dataset(:,1),dataset(:,2),dataset(:,4));hold on; % 画数据集里的数据
scatter3(dataset(:,1),dataset(:,2),pred_label1(:,2));hold on; % 画逆解算的结果
xlabel('外倾角');
ylabel('旋转角');
zlabel('BA高度差');
figure; % 这幅图展示了逆解算结果与数据集的误差
% 越接近0说明运动逆解算精度越高
scatter3(dataset(:,1),dataset(:,2),dataset(:,3)-pred_label1(:,1));hold on; % 逆解算BA高度差时的误差
scatter3(dataset(:,1),dataset(:,2),dataset(:,4)-pred_label1(:,2));hold on; % 逆解算CA高度差时的误差
xlabel('外倾角');
ylabel('旋转角');
zlabel('逆解算结果与数据集的误差');
%% 计算mse
mse = sqrt(mean((dataset(:,3:4)-pred_label1).^2))
mse = sqrt(mean((dataset(:,3:4)-pred_label2).^2))
%   0.5939    0.5211 % 浮点神经网络的mse
%   0.5897    0.6241 % FPGA定点化神经网络的mse
aaa = dataset(:,3:4)-pred_label1;
figure;
plot(aaa(:,1));hold on;
plot(aaa(:,2));hold on;

