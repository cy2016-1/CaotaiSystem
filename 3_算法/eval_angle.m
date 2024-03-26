clc;
clear all;
close all;
%% ������
fp = fopen('dataset_angle.txt','r');
dataset = cell2mat(textscan(fp,'%.4f'));
dataset = reshape(dataset,[4 length(dataset)/4]);
dataset = dataset';
% dataset_angle.txt����˽ǶȽ�������ݼ���ÿһ����һ�����������ݣ���һ����
% ����ǣ��ڶ�������ת�ǣ���������B���A��߶�֮���������C���A��߶�֮�
% �Ƕȵĵ�λ�Ƕȣ��߶Ȳ�ĵ�λ��mm
%% �˶�����㣨�����磩�������ǽǶ�ֵ�������BA�߶Ȳ��BC�߶Ȳ�
pred_data1 = dataset(:,1:2); % pred_data1�ǽǶ�ֵ
[pred_label1] = function_predict(pred_data1, 1); % pred_label1��BA�߶Ȳ��BC�߶Ȳ�
[pred_label2] = function_predict_fpga(pred_data1,1);
%% ��ͼ
figure; % ���ͼչʾ��BA�߶Ȳ������ǡ���ת��֮��Ĺ�ϵ
% ��������ͼ����һ������Խ��˵���˶�����㾫��Խ��
scatter3(dataset(:,1),dataset(:,2),dataset(:,3));hold on; % �����ݼ��������
scatter3(dataset(:,1),dataset(:,2),pred_label1(:,1));hold on; % �������Ľ��
xlabel('�����');
ylabel('��ת��');
zlabel('BA�߶Ȳ�');
figure; % ���ͼչʾ��CA�߶Ȳ������ǡ���ת��֮��Ĺ�ϵ
% ��������ͼ����һ������Խ��˵���˶�����㾫��Խ��
scatter3(dataset(:,1),dataset(:,2),dataset(:,4));hold on; % �����ݼ��������
scatter3(dataset(:,1),dataset(:,2),pred_label1(:,2));hold on; % �������Ľ��
xlabel('�����');
ylabel('��ת��');
zlabel('BA�߶Ȳ�');
figure; % ���ͼչʾ��������������ݼ������
% Խ�ӽ�0˵���˶�����㾫��Խ��
scatter3(dataset(:,1),dataset(:,2),dataset(:,3)-pred_label1(:,1));hold on; % �����BA�߶Ȳ�ʱ�����
scatter3(dataset(:,1),dataset(:,2),dataset(:,4)-pred_label1(:,2));hold on; % �����CA�߶Ȳ�ʱ�����
xlabel('�����');
ylabel('��ת��');
zlabel('������������ݼ������');
%% ����mse
mse = sqrt(mean((dataset(:,3:4)-pred_label1).^2))
mse = sqrt(mean((dataset(:,3:4)-pred_label2).^2))
%   0.5939    0.5211 % �����������mse
%   0.5897    0.6241 % FPGA���㻯�������mse
aaa = dataset(:,3:4)-pred_label1;
figure;
plot(aaa(:,1));hold on;
plot(aaa(:,2));hold on;

