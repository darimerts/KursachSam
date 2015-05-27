close all
clear all

%Открываем файл и считываем столбец
fileID = fopen('C:\Users\Дарина\Documents\Курсовая_Самородов\РЭГ_1.txt','r');
formatSpec = '%d';
A = fscanf(fileID,formatSpec);
fclose(fileID);

%Задание времени и амплитуды
i = 1:length(A);
Fd = 200;
Time = i/Fd;
U = A/(10^3);
I = 1/(10^3);
R = U/I;



%Вывод графика
figure;
plot(Time,R);

%производная
Udif = diff(R)*Fd;
Udif(length(A)) = 0;

%Вывод графика
figure;
plot(Time,Udif);

%Поиск амплитуды инцизуры

%for i=(1:1:(length(A)-1)
   % if A

