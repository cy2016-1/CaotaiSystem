function [alpha, belta, foot_pos] = function_cross(posX, posY, posZ)
%% 本函数的功能是根据XYZ三点的坐标求出外倾角、旋转角和足底坐标
% 这里首先引用"function_forward.m"文件里面对第二套三维直角坐标系、XYZ三点
% 坐标的定义，然后我们定义外倾角alpha、旋转角belta和足底坐标foot_pos，最
% 后根据XYZ三点的坐标求出外倾角alpha、旋转角belta和足底坐标foot_pos。
% 本函数提到的所有坐标系都是指第二套三维直角坐标系
% 外倾角：三点决定唯一的平面，XYZ三点决定的平面的法向量我们称之为face_vector，
% 那么我们把face_vector和z轴正方向的夹角定义为外倾角
% 旋转角：法向量face_vector在xoy平面的投影向量和x轴正方向的夹角
% 足底坐标：已知草太的脚尖和XYZ平面的距离是208mm，草太脚尖的坐标即为足底坐标
x = posX; % X点的坐标
y = posY; % Y点的坐标
z = posZ; % Z点的坐标
face_vector = cross(x-y,y-z); % XYZ平面的法向量
if (face_vector(3)<0) % 让法向量的方向指向z轴正方向
    face_vector = -face_vector;
end
% 所以face_vector(1)是法向量的x轴分量，face_vector(2)是法向量的y轴分量，
% face_vector(3)是法向量的z轴分量
%% 法向量与z轴的夹角alpha
face_v_mod = (sum(face_vector.^2)).^(1/2); % 法向量的模
cosalpha = face_vector(3) / face_v_mod; % z轴分量除以模长即为外倾角alpha
alpha = acos(cosalpha) / pi * 180;
%% 法向量在xoy平面的投影与x轴的夹角belta
proj_xoy_mod = (sum(face_vector(1:2).^2)).^(1/2); % 只保留法向量的x分量
% 和y分量即可得到法向量在xoy平面的投影，然后求其模长即为投影的模长
cosbelta = face_vector(1) / proj_xoy_mod; % x轴分量除以投影模长即为旋转角的余弦值
belta = acos(cosbelta) / pi * 180; % 根据余弦值求反余弦即可得到旋转角belta
if (face_vector(2)<0) % 在y分量为负时，对旋转角取反
    belta = -belta;
end
%% 三角形中心点的坐标
pos_c = (x+y+z) / 3; % 等边三角形XYZ的中心点可以由坐标的平均值得到
%% 单位法向量
face_v_unit = face_vector / face_v_mod; % 法向量的单位向量
%% 足底坐标
foot_pos = pos_c + face_v_unit * 208; % 中心点坐标+208*单位向量即为草太脚尖的坐标

