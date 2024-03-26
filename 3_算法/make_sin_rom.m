clc;
clear all;
close all;
% Ϊ�˼�С��̫�Ȳ��˶�ʱ�ĸ��Գ�������Գ�����˶�ʱ�ļӼ������߲���S����
% ѡ��������S���ߣ�����ű������������Һ������ұ�FPGAʹ��
t = -pi/2:pi/1000:pi/2-pi/1000;
data = (sin(t)+1)/2;
ddd = zeros(1,1024);
ddd(1:1000) = ceil(data*255);
plot(ddd);
fid = fopen('sin.coe','w');
fprintf(fid,'memory_initialization_radix = 16;\n');
fprintf(fid,'memory_initialization_vector = ');
fprintf(fid,'%s',dec2hex(ddd(1),3));
for i=2:1024
    fprintf(fid,',\n%s',dec2hex(ddd(i),3));
end
fprintf(fid,';\n');
fclose(fid);
fid = fopen('sin.mif','w');
fprintf(fid,'DEPTH=1024;\n');
fprintf(fid,'WIDTH=9;\n');
fprintf(fid,'ADDRESS_RADIX=HEX;\n');
fprintf(fid,'DATA_RADIX=HEX;\n');
fprintf(fid,'CONTENT\n');
fprintf(fid,'BEGIN\n');
for i=1:1024
    addr = dec2hex(i-1,3);
    data = dec2hex(ddd(i),3);
    fprintf(fid,'%s:%s;\n',addr,data);
end
fprintf(fid,'END;\n');
fclose(fid);
