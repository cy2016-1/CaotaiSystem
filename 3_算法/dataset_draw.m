clc;
clear all;
close all;
f1 = fopen('dataset_draw.txt','r');
% dataset_draw.txt存放了脚尖位置解算的数据集，每一行都是一条单独的数据，第一列
% 是草太脚尖的x轴坐标，第二列是脚尖的y轴坐标，第三列是z轴坐标减220（这里减220
% 的意思是如果草太脚尖z轴坐标是247，则只存放27，使得脚尖的x轴、y轴、z轴坐标数
% 值大小差不多，从而提升神经网络的精度），第四列是当草太脚尖处在该位置时的A点高
% 度，第五列和第六列则分别是B点和C点高度，单位都是毫米mm
data1 = cell2mat(textscan(f1,'%.4f'));
fclose(f1);
data1 = reshape(data1,[6 length(data1)/6]);
data1 = data1';
data1 = data1(:,1:3);
%% 生成测试集
DATA_SIZE = 5;
pos_test = zeros(DATA_SIZE,3);
k = 0;
while (k<DATA_SIZE)
    x = rand()*200-100; % 随机值x轴坐标范围-100到100
    y = rand()*200-100; % 随机值y轴坐标范围-100到100
    % 这里z = 247-220是个提升神经网络精度的小trick，它使z轴坐标和x、y轴处在了同一数量级
    z = 247-220;
    ddd1 = abs(data1(:,1)-x);
    ddd2 = abs(data1(:,2)-y);
    ppp = find(ddd1<0.02 & ddd2<0.02);
    % 如果差值小于0.02，则舍弃该数据
    if (~isempty(ppp))
        continue;
    end
    if (x*x+y*y<10000)
        k = k+1;
        pos_test(k,:) = [x y z];
    end
end
%% 计算
err_set = zeros(DATA_SIZE,3);
f1 = fopen('dataset_draw_extend.txt','w');
for i=1:DATA_SIZE
    tic
    pred_data1 = pos_test(i,:);
    % 首先进行运动逆解算，得到ABC三点的高度
    [pred_label1] = function_predict(pred_data1, 2);
    % 接着进行运动正解算，得到XYZ三点坐标
    [resX_high, resY_high, resZ_high]...
    =function_forward(pred_label1(1), pred_label1(2), pred_label1(3));
    % 然后根据XYZ三点坐标得到精确地脚尖坐标
    [~, ~, foot_pos] = function_cross(resX_high, resY_high, resZ_high);
    % 这个减220是神经网络的trick，前面已经讲过的啦
    foot_pos(3) = foot_pos(3) - 220;
    ERR = foot_pos - pred_data1;
    fprintf('运动逆解算输入的足底坐标为(%.4f,%.4f,%.4f)\n',pred_data1(1),pred_data1(2),pred_data1(3));
    fprintf('运动逆解算得到的ABC三点高度为(%.4f,%.4f,%.4f)\n',pred_label1(1),pred_label1(2),pred_label1(3));
    fprintf('运动正解算得到的足底坐标为(%.4f,%.4f,%.4f)\n',foot_pos(1),foot_pos(2),foot_pos(3));
    fprintf('now i=%d, ERR is %.4f %.4f %.4f\n',i,ERR(1),ERR(2),ERR(3));
    err_set(i,:) = ERR;
    fprintf(f1,'%.4f %.4f %.4f ',foot_pos(1),foot_pos(2),foot_pos(3));
    fprintf(f1,'%.4f %.4f %.4f\n',pred_label1(1),pred_label1(2),pred_label1(3));
    toc
end
fclose(f1);
figure;
plot(err_set(:,1));hold on;
plot(err_set(:,2));hold on;
plot(err_set(:,3));hold on;


