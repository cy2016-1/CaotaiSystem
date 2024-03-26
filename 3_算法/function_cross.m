function [alpha, belta, foot_pos] = function_cross(posX, posY, posZ)
%% �������Ĺ����Ǹ���XYZ����������������ǡ���ת�Ǻ��������
% ������������"function_forward.m"�ļ�����Եڶ�����άֱ������ϵ��XYZ����
% ����Ķ��壬Ȼ�����Ƕ��������alpha����ת��belta���������foot_pos����
% �����XYZ�����������������alpha����ת��belta���������foot_pos��
% �������ᵽ����������ϵ����ָ�ڶ�����άֱ������ϵ
% ����ǣ��������Ψһ��ƽ�棬XYZ���������ƽ��ķ��������ǳ�֮Ϊface_vector��
% ��ô���ǰ�face_vector��z��������ļнǶ���Ϊ�����
% ��ת�ǣ�������face_vector��xoyƽ���ͶӰ������x��������ļн�
% ������꣺��֪��̫�Ľż��XYZƽ��ľ�����208mm����̫�ż�����꼴Ϊ�������
x = posX; % X�������
y = posY; % Y�������
z = posZ; % Z�������
face_vector = cross(x-y,y-z); % XYZƽ��ķ�����
if (face_vector(3)<0) % �÷������ķ���ָ��z��������
    face_vector = -face_vector;
end
% ����face_vector(1)�Ƿ�������x�������face_vector(2)�Ƿ�������y�������
% face_vector(3)�Ƿ�������z�����
%% ��������z��ļн�alpha
face_v_mod = (sum(face_vector.^2)).^(1/2); % ��������ģ
cosalpha = face_vector(3) / face_v_mod; % z���������ģ����Ϊ�����alpha
alpha = acos(cosalpha) / pi * 180;
%% ��������xoyƽ���ͶӰ��x��ļн�belta
proj_xoy_mod = (sum(face_vector(1:2).^2)).^(1/2); % ֻ������������x����
% ��y�������ɵõ���������xoyƽ���ͶӰ��Ȼ������ģ����ΪͶӰ��ģ��
cosbelta = face_vector(1) / proj_xoy_mod; % x���������ͶӰģ����Ϊ��ת�ǵ�����ֵ
belta = acos(cosbelta) / pi * 180; % ��������ֵ�����Ҽ��ɵõ���ת��belta
if (face_vector(2)<0) % ��y����Ϊ��ʱ������ת��ȡ��
    belta = -belta;
end
%% ���������ĵ������
pos_c = (x+y+z) / 3; % �ȱ�������XYZ�����ĵ�����������ƽ��ֵ�õ�
%% ��λ������
face_v_unit = face_vector / face_v_mod; % �������ĵ�λ����
%% �������
foot_pos = pos_c + face_v_unit * 208; % ���ĵ�����+208*��λ������Ϊ��̫�ż������

