function [posX, posY, posZ] = function_forward(h_A, h_B, h_C)
%% 本函数的功能是输入指定的A点高度、B点高度、C点高度，得出X、Y、Z三点的坐标
% 那么ABCXYZ点具体是指哪6个点呢？直角坐标系又是定义在哪里的呢？
% 请参考同文件夹下的图片：“点和坐标系定义.png”
% （1）首先定义ABC三点：我们知道万向节连接了零件“伸缩连杆”和“大腿连杆”，草太的每
% 条腿都由三套万向节+伸缩连杆+大腿连杆构成，我们定义最内侧（最内侧指的是最靠近椅面中
% 心）的那套的万向节的对称中心（万向节为中心对称图形，这里“对称中心”指的是使之中心
% 对称的旋转中心）为A点，从下往上看逆时针旋转，余下的两套依次是B点和C点。
% （2）我们再定义XYZ三点：零件“大腿连杆”用于安装滑动轴承的那个圆环的中心看到了吧？
% X点对应A点所在万向节连接的那个大腿连杆的圆环中心，Y点对应B点，Z点对应C点。
% （3）然后我们再定义两套三维直角坐标系，第一套的xoy平面位于XYZ平面，原点o位于XYZ三
% 点构成的等边三角形的重心，X点位于x轴上，z轴的正方向等于向量YX叉乘向量XZ，上述条件
% 可以完全定义该直角坐标系。
% （4）定义第二套三维直角坐标系：零件“伸缩连杆”和“十二轴连接器”之间的那个滑动轴
% 承看到了吧？我们定义滑动轴承的底面为第二套的xoy平面，原点o位于A点在xoy平面的投影，
% y轴的正方向等于向量BC（y轴不与线段BC重合，只是y轴正方向等于向量BC的方向），z轴的
% 正方向等于向量AB叉乘向量BC，上述条件可以完全定义该直角坐标系。
% （5）所以本函数输入的h_A参数即为A点高度（或称A点到第二套坐标系的xoy平面距离），h_B
% 即为B点高度，h_C即为C点高度，输出的X、Y、Z三点坐标也是相对第二套坐标系的。
L = 22.6;% L是万向节中心到大腿连杆轴承中心的距离
D = 15;% D是A点和三角形ABC重心之间的直线距离
R = 18;% 零件“十二轴连接器”上安装的法兰外径18mm的滑动轴承看到了吧？每三个这种滑动
% 轴承紧挨着构成了等边三角形，该等边三角形的边长就是18mm
% 本代码的所有长度单位都是毫米mm
%% 第一套坐标系下ABC坐标定义
syms a b c % 定义的a、b、c是角度，A点所在万向节连接了“伸缩连杆”和“大腿连杆”，
% 伸缩连杆中轴线构成的锐角即为角a，同理，B、C两点对应了角b、角c
pos_A = [           1 * (D-L*sin(a))
                    0 * (D-L*sin(a))
                    L *      cos(a)];% 第一个直角坐标系下的A点坐标
pos_B = [-(1/4)^(1/2) * (D-L*sin(b))
         -(3/4)^(1/2) * (D-L*sin(b))
                    L *      cos(b)];% 第一个直角坐标系下的B点坐标
pos_C = [-(1/4)^(1/2) * (D-L*sin(c))
          (3/4)^(1/2) * (D-L*sin(c))
                    L *      cos(c)];% 第一个直角坐标系下的C点坐标
%% 第一个3元2次方程组，用于求角a、角b、角c
dis_AB = (R^2 + (h_A-h_B)^2)^(1/2);% A点和B点之间的距离
dis_BC = (R^2 + (h_B-h_C)^2)^(1/2);% B点和C点之间的距离
dis_AC = (R^2 + (h_A-h_C)^2)^(1/2);% A点和C点之间的距离
% 列出三个方程组，其中有三个未知数
eq1 = (sum((pos_A-pos_B).^2) == dis_AB.^2);
eq2 = (sum((pos_A-pos_C).^2) == dis_AC.^2);
eq3 = (sum((pos_B-pos_C).^2) == dis_BC.^2);
% 解方程
S = solve([eq1 eq2 eq3], [a b c],'IgnoreAnalyticConstraints',true);
%% 第一套坐标系下XYZ坐标定义
pos_X = [D 0 0];% 第一个直角坐标系下的X点坐标
pos_Y = [-(1/4)^(1/2)*D -(3/4)^(1/2)*D 0];% 第一个直角坐标系下的Y点坐标
pos_Z = [-(1/4)^(1/2)*D  (3/4)^(1/2)*D 0];% 第一个直角坐标系下的Z点坐标
%% 根据第一套坐标系下XYZ点坐标、ABC点坐标求出点点之间距离
dis_XA = sum((eval(subs(pos_A,a,S.a))-pos_X').^2)^(1/2);% X点和A点之间的距离
dis_XB = sum((eval(subs(pos_B,b,S.b))-pos_X').^2)^(1/2);% X点和B点之间的距离
dis_XC = sum((eval(subs(pos_C,c,S.c))-pos_X').^2)^(1/2);% X点和C点之间的距离
dis_YA = sum((eval(subs(pos_A,a,S.a))-pos_Y').^2)^(1/2);% Y点和A点之间的距离
dis_YB = sum((eval(subs(pos_B,b,S.b))-pos_Y').^2)^(1/2);% Y点和B点之间的距离
dis_YC = sum((eval(subs(pos_C,c,S.c))-pos_Y').^2)^(1/2);% Y点和C点之间的距离
dis_ZA = sum((eval(subs(pos_A,a,S.a))-pos_Z').^2)^(1/2);% Z点和A点之间的距离
dis_ZB = sum((eval(subs(pos_B,b,S.b))-pos_Z').^2)^(1/2);% Z点和B点之间的距离
dis_ZC = sum((eval(subs(pos_C,c,S.c))-pos_Z').^2)^(1/2);% Z点和C点之间的距离
% 至此，点点之间的距离确定下来了，第一个坐标系的任务也结束了
% 接下来的代码都是在第二个坐标系中进行，不会再用第一个坐标系了
%% 第二套坐标系下ABC坐标定义
pos_A = [0 0 h_A];
pos_B = [(3/4)^(1/2)*R -(1/4)^(1/2)*R h_B];
pos_C = [(3/4)^(1/2)*R  (1/4)^(1/2)*R h_C];
%% 第二个3元2次方程组，用于求第二套坐标系下X点坐标
syms Xx Xy Xz % Xx、Xy和Xz分别是X点的x轴、y轴、z轴坐标
pos_X = [Xx Xy Xz];
% 列出三个方程组，其中有三个未知数
eq1 = (sum((pos_A-pos_X).^2) == dis_XA^2);
eq2 = (sum((pos_B-pos_X).^2) == dis_XB^2);
eq3 = (sum((pos_C-pos_X).^2) == dis_XC^2);
% 解方程
S = solve([eq1 eq2 eq3], [Xx Xy Xz],'ReturnConditions',true,'IgnoreAnalyticConstraints',true);
sXx = eval(vpa(S.Xx));
sXy = eval(vpa(S.Xy));
sXz = eval(vpa(S.Xz));
%% 第三个3元2次方程组，用于求第二套坐标系下Y点坐标
syms Yx Yy Yz % Yx、Yy和Yz分别是Y点的x轴、y轴、z轴坐标
pos_Y = [Yx Yy Yz];
% 列出三个方程组，其中有三个未知数
eq1 = (sum((pos_A-pos_Y).^2) == dis_YA^2);
eq2 = (sum((pos_B-pos_Y).^2) == dis_YB^2);
eq3 = (sum((pos_C-pos_Y).^2) == dis_YC^2);
% 解方程
S = solve([eq1 eq2 eq3], [Yx Yy Yz],'ReturnConditions',true,'IgnoreAnalyticConstraints',true);
sYx = eval(vpa(S.Yx));
sYy = eval(vpa(S.Yy));
sYz = eval(vpa(S.Yz));
%% 第四个3元2次方程组，用于求第二套坐标系下Z点坐标
syms Zx Zy Zz % Zx、Zy和Zz分别是Z点的x轴、y轴、z轴坐标
pos_Z = [Zx Zy Zz];
% 列出三个方程组，其中有三个未知数
eq1 = (sum((pos_A-pos_Z).^2) == dis_ZA^2);
eq2 = (sum((pos_B-pos_Z).^2) == dis_ZB^2);
eq3 = (sum((pos_C-pos_Z).^2) == dis_ZC^2);
% 解方程
S = solve([eq1 eq2 eq3], [Zx Zy Zz],'ReturnConditions',true,'IgnoreAnalyticConstraints',true);
sZx = eval(vpa(S.Zx));
sZy = eval(vpa(S.Zy));
sZz = eval(vpa(S.Zz));
%% 计算返回值
% 聪明的小伙伴可能注意到了第二、三、四个方程组，在求XYZ点坐标时，结果是两个解，
% 这两个解分别位于平面ABC的两侧，而正确的解只能位于面ABC的下方，所以舍弃z轴坐标
% 低的那个解（z轴正方向指向面ABC的下方）。
if (sXz(2)>sXz(1))
    posX = [sXx(2) sXy(2) sXz(2)];
else
    posX = [sXx(1) sXy(1) sXz(1)];
end
if (sYz(2)>sYz(1))
    posY = [sYx(2) sYy(2) sYz(2)];
else
    posY = [sYx(1) sYy(1) sYz(1)];
end
if (sZz(2)>sZz(1))
    posZ = [sZx(2) sZy(2) sZz(2)];
else
    posZ = [sZx(1) sZy(1) sZz(1)];
end
%% 写在最后
% 本代码需要求X、Y、Z三点的三维坐标，所以共有9个未知数，所以另一种算法是列
% 出9个方程直接求解这9个未知数，相应的代码如下：
% pos_A = [0 0 h_A];
% pos_B = [(3/4)^(1/2)*R -(1/4)^(1/2)*R h_B];
% pos_C = [(3/4)^(1/2)*R  (1/4)^(1/2)*R h_C];
% syms Xx Xy Xz Yx Yy Yz Zx Zy Zz
% pos_X = [Xx Xy Xz];
% pos_Y = [Yx Yy Yz];
% pos_Z = [Zx Zy Zz];
% eq1 = (sum((pos_X-pos_A).^2) == L^2);
% eq2 = (sum((pos_Y-pos_B).^2) == L^2);
% eq3 = (sum((pos_Z-pos_C).^2) == L^2);
% eq4 = (sum((pos_X-pos_Y).^2) == 3*D^2);
% eq5 = (sum((pos_X-pos_Z).^2) == 3*D^2);
% eq6 = (sum((pos_Y-pos_Z).^2) == 3*D^2);
% eq7 = (sum((pos_A-pos_Y).^2) == sum((pos_A-pos_Z).^2));
% eq8 = (sum((pos_B-pos_X).^2) == sum((pos_B-pos_Z).^2));
% eq9 = (sum((pos_C-pos_X).^2) == sum((pos_C-pos_Y).^2));
% S = solve([eq1 eq2 eq3 eq4 eq5 eq6 eq7 eq8 eq9], [Xx Xy Xz Yx Yy Yz Zx Zy Zz],...
%     'ReturnConditions',true,'IgnoreAnalyticConstraints',true);
% 但是上述代码的解有16个，我们需要舍弃其中15个，但是我们很难确定舍弃哪15个（摊手）
% 本代码采用4组三元二次方程组替代9元二次方程组，从而解决解太多不知道如何舍弃的问题，
% 这也算是本代码的一大创新点吧（哈哈哈哈哈自夸一下）
