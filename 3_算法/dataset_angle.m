clc;
clear all;
close all;
HMAX = 48.0;
HMIN = 15.0;
%% ���ļ�
fid1 = fopen('dataset_angle.txt','r');
% dataset_angle.txt����˽ǶȽ�������ݼ���ÿһ����һ�����������ݣ���һ����
% ����ǣ��ڶ�������ת�ǣ���������B���A��߶�֮���������C���A��߶�֮�
% �Ƕȵĵ�λ�Ƕȣ��߶Ȳ�ĵ�λ��mm
data1 = cell2mat(textscan(fid1,'%.4f'));
fclose(fid1);
data1 = reshape(data1,4,length(data1)/4);
data1 = data1';
data1 = data1(:,1:2);
%% ���ɲ��Լ�
DATA_SIZE = 10;
dif_data = zeros(DATA_SIZE,2);
k = 0;
while (k<DATA_SIZE)
    % dif1��B���A��߶�֮�dif2��C���A��߶�֮��
    dif1 = rand()*(HMAX-HMIN); % ���ɵ����ֵλ��HMIN��HMAX֮��
    dif2 = rand()*(HMAX-HMIN);
    % ddd��ʾ���ɵ����ֵ���������ݵĲ�ֵ
    ddd1 = abs(data1(1:end,1) - dif1);
    ddd2 = abs(data1(1:end,2) - dif2);
    % �����ֵС��0.02�������������ݣ�����ȥ�ص�����
    ppp = find((ddd1<0.02) & (ddd2<0.02));
    if (~isempty(ppp))
        continue;
    end
    k = k+1;
    % �����ֵ����0.02������ܸ�����
    dif_data(k,:) = [dif1 dif2];
end
%% ����
err_set = zeros(DATA_SIZE,2);
alpha = zeros(DATA_SIZE,1);
belta = zeros(DATA_SIZE,1);
f1 = fopen('dataset_angle_extend.txt','w');
for i=1:DATA_SIZE
    tic
    ha = 48; % �̶�A��߶�Ϊ48mm
    hb = ha + dif_data(i,1); % ����A��߶Ⱥ�B��A��߶�֮�����B��߶�
    hc = ha + dif_data(i,2); % ����A��߶Ⱥ�C��A��߶�֮�����C��߶�
    % ����ABC����߶����XYZ����
    [posX, posY, posZ] = function_forward(ha, hb, hc);
    % ����XYZ����������������Ǻ���ת��
    [alpha(i), belta(i), ~] = function_cross(posX, posY, posZ);
    % ��������Ǻ���ת�ǽ����˶�����㣬���BA��BC�߶Ȳ�
    [pred_label1] = function_predict([alpha(i), belta(i)], 1);
    fprintf('�˶������������BA��BC�߶Ȳ�Ϊ(%.4f,%.4f)\n',dif_data(i,1), dif_data(i,2));
    fprintf('�˶�������õ�������Ǻ���ת��Ϊ(%.4f,%.4f)\n',alpha(i), belta(i));
    fprintf('�˶������õ���BA��BC�߶Ȳ�Ϊ(%.4f,%.4f)\n',pred_label1(1), pred_label1(2));
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
