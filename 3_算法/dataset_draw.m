clc;
clear all;
close all;
f1 = fopen('dataset_draw.txt','r');
% dataset_draw.txt����˽ż�λ�ý�������ݼ���ÿһ�ж���һ�����������ݣ���һ��
% �ǲ�̫�ż��x�����꣬�ڶ����ǽż��y�����꣬��������z�������220�������220
% ����˼�������̫�ż�z��������247����ֻ���27��ʹ�ýż��x�ᡢy�ᡢz��������
% ֵ��С��࣬�Ӷ�����������ľ��ȣ����������ǵ���̫�ż⴦�ڸ�λ��ʱ��A���
% �ȣ������к͵�������ֱ���B���C��߶ȣ���λ���Ǻ���mm
data1 = cell2mat(textscan(f1,'%.4f'));
fclose(f1);
data1 = reshape(data1,[6 length(data1)/6]);
data1 = data1';
data1 = data1(:,1:3);
%% ���ɲ��Լ�
DATA_SIZE = 5;
pos_test = zeros(DATA_SIZE,3);
k = 0;
while (k<DATA_SIZE)
    x = rand()*200-100; % ���ֵx�����귶Χ-100��100
    y = rand()*200-100; % ���ֵy�����귶Χ-100��100
    % ����z = 247-220�Ǹ����������羫�ȵ�Сtrick����ʹz�������x��y�ᴦ����ͬһ������
    z = 247-220;
    ddd1 = abs(data1(:,1)-x);
    ddd2 = abs(data1(:,2)-y);
    ppp = find(ddd1<0.02 & ddd2<0.02);
    % �����ֵС��0.02��������������
    if (~isempty(ppp))
        continue;
    end
    if (x*x+y*y<10000)
        k = k+1;
        pos_test(k,:) = [x y z];
    end
end
%% ����
err_set = zeros(DATA_SIZE,3);
f1 = fopen('dataset_draw_extend.txt','w');
for i=1:DATA_SIZE
    tic
    pred_data1 = pos_test(i,:);
    % ���Ƚ����˶�����㣬�õ�ABC����ĸ߶�
    [pred_label1] = function_predict(pred_data1, 2);
    % ���Ž����˶������㣬�õ�XYZ��������
    [resX_high, resY_high, resZ_high]...
    =function_forward(pred_label1(1), pred_label1(2), pred_label1(3));
    % Ȼ�����XYZ��������õ���ȷ�ؽż�����
    [~, ~, foot_pos] = function_cross(resX_high, resY_high, resZ_high);
    % �����220���������trick��ǰ���Ѿ���������
    foot_pos(3) = foot_pos(3) - 220;
    ERR = foot_pos - pred_data1;
    fprintf('�˶������������������Ϊ(%.4f,%.4f,%.4f)\n',pred_data1(1),pred_data1(2),pred_data1(3));
    fprintf('�˶������õ���ABC����߶�Ϊ(%.4f,%.4f,%.4f)\n',pred_label1(1),pred_label1(2),pred_label1(3));
    fprintf('�˶�������õ����������Ϊ(%.4f,%.4f,%.4f)\n',foot_pos(1),foot_pos(2),foot_pos(3));
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


