close all
clear all

%��������� ���� � ��������� �������
fileID = fopen('C:\Users\������\Documents\��������_���������\���_1.txt','r');
formatSpec = '%d';
A = fscanf(fileID,formatSpec);
fclose(fileID);

%������� ������� � ���������
i = 1:length(A);
Fd = 200;
Time = i/Fd;
U = A/(10^3);
I = 1/(10^3);
R = U/I;



%����� �������
figure;
plot(Time,R);

%�����������
Udif = diff(R)*Fd;
Udif(length(A)) = 0;

%����� �������
figure;
plot(Time,Udif);

%����� ��������� ��������

%for i=(1:1:(length(A)-1)
   % if A

