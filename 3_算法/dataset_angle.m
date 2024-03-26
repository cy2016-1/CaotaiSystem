clc;
clear all;
close all;
HMAX = 48.0;
HMIN = 15.0;
%% 读文件
fid1 = fopen('dataset_angle.txt','r');
% dataset_angle.txt存放了角度解算的数据集，每一行是一条单独的数据，第一列是
% 外倾角，第二列是旋转角，第三列是B点和A点高度之差，第四列是C点和A点高度之差，
% 角度的单位是度，高度差的单位是mm
data1 = cell2mat(textscan(fid1,'%.4f'));
fclose(fid1);
data1 = reshape(data1,4,length(data1)/4);
data1 = data1';
data1 = data1(:,1:2);
%% 生成测试集
DATA_SIZE = 10;
dif_data = zeros(DATA_SIZE,2);
k = 0;
while (k<DATA_SIZE)
    % dif1是B点和A点高度之差，dif2是C点和A点高度之差
    dif1 = rand()*(HMAX-HMIN); % 生成的随机值位于HMIN到HMAX之间
    dif2 = rand()*(HMAX-HMIN);
    % ddd表示生成的随机值和已有数据的差值
    ddd1 = abs(data1(1:end,1) - dif1);
    ddd2 = abs(data1(1:end,2) - dif2);
    % 如果差值小于0.02，则舍弃该数据，起到了去重的作用
    ppp = find((ddd1<0.02) & (ddd2<0.02));
    if (~isempty(ppp))
        continue;
    end
    k = k+1;
    % 如果差值大于0.02，则接受该数据
    dif_data(k,:) = [dif1 dif2];
end
%% 计算
err_set = zeros(DATA_SIZE,2);
alpha = zeros(DATA_SIZE,1);
belta = zeros(DATA_SIZE,1);
f1 = fopen('dataset_angle_extend.txt','w');
for i=1:DATA_SIZE
    tic
    ha = 48; % 固定A点高度为48mm
    hb = ha + dif_data(i,1); % 根据A点高度和B点A点高度之差算出B点高度
    hc = ha + dif_data(i,2); % 根据A点高度和C点A点高度之差算出C点高度
    % 根据ABC三点高度求出XYZ坐标
    [posX, posY, posZ] = function_forward(ha, hb, hc);
    % 根据XYZ三点的坐标求出外倾角和旋转角
    [alpha(i), belta(i), ~] = function_cross(posX, posY, posZ);
    % 根据外倾角和旋转角进行运动逆解算，求出BA、BC高度差
    [pred_label1] = function_predict([alpha(i), belta(i)], 1);
    fprintf('运动正解算输入的BA、BC高度差为(%.4f,%.4f)\n',dif_data(i,1), dif_data(i,2));
    fprintf('运动正解算得到的外倾角和旋转角为(%.4f,%.4f)\n',alpha(i), belta(i));
    fprintf('运动逆解算得到的BA、BC高度差为(%.4f,%.4f)\n',pred_label1(1), pred_label1(2));
    ERR = dif_data(i,1:2) - pred_label1;
    fprintf('now i=%d, ERR is %.4f %.4f\n',i,ERR(1),ERR(2));
    err_set(i,:) = ERR;
    fprintf(f1,'%.4f %.4f %.4f %.4f\n',alpha(i), belta(i),dif_data(i,1), dif_data(i,2));
    toc
end
fclose(f1);

figure;
plot(err_set(:,1));hold on;
plot(err_set(:,2));hold on;
