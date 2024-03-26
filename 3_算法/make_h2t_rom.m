clc;
clear all;
close all;
% ����������������ɹ�FPGAʹ�õĲ��ұ����ұ������H���������˵ĸ߶ȣ����ұ��
% ���T�Ƕ����������ĸߵ�ƽʱ��
% R�ĺ���������ֵİ뾶���������0�˶���180��ʱ�����������˶�pi*R
R = 20;
data = [];
for i=1:4:8192
    T = function_h2t(i,R);
    data = [data T];
end
ddd = round(data);
figure;
plot((1:4:8192)/128, ddd);
fid = fopen('h2t.coe','w');
fprintf(fid,'memory_initialization_radix = 16;\n');
fprintf(fid,'memory_initialization_vector = ');
fprintf(fid,'%s',dec2hex(ddd(1),4));
for i=2:2048
    fprintf(fid,',\n%s',dec2hex(ddd(i),4));
end
fprintf(fid,';\n');
fclose(fid);
fid = fopen('h2t.mif','w');
fprintf(fid,'DEPTH=2048;\n');
fprintf(fid,'WIDTH=16;\n');
fprintf(fid,'ADDRESS_RADIX=HEX;\n');
fprintf(fid,'DATA_RADIX=HEX;\n');
fprintf(fid,'CONTENT\n');
fprintf(fid,'BEGIN\n');
for i=1:2048
    addr = dec2hex(i-1,3);
    data = dec2hex(ddd(i),4);
    fprintf(fid,'%s:%s;\n',addr,data);
end
fprintf(fid,'END;\n');
fclose(fid);

function T = function_h2t(h,R)
% ����128�ĺ�����H��7λ����С����2^7=128
if (h<15*128) % ��С��H��15mm�����ڴ��ڽṹ�ϱ���λ�����ɴ�
    H = 15;
elseif (h>48*128) % ����H��48mm�����ڴ��ڽṹ�ϱ���λ�����ɴ�
    H = 48;
else
    H = h/128;
end
A = asin((H-31.5) / R) / pi*180;
T = -A*100/9 + 1500;
end
