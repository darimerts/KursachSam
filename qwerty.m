close all
clear all

%Открываем файл и считываем столбец
fileID = fopen('РЭГ_1.txt','r');
formatSpec = '%d';
A = fscanf(fileID,formatSpec);
fclose(fileID);

%Задание времени и амплитуды диф.регоэнцефалограммы
N = length(A);
i = 1:N;
Fd = 200;
Time = i/Fd;
U = A/(10^3);
I = 1/(10^3);
R = U/I;
d=length(R);
%Вычисление реограммы
sym(1)=0;
for i=(2:1:N)
  sym(i)=R(i-1)+sym(i-1); 
end;
Rint=sym;

%Вывод графика полученной РЭГ
figure;
plot(Time,Rint);

FF1=fft(Rint);
%F1=50; F2=30;
Flow=0;
Tov=N/Fd;
dF=1/Tov;
F(i)=i*dF;
j=1:1:N/2;
%figure;
%plot(abs(FF1(j)),F(i));



%Расчет и построение спектра РЭГ
N1=length(Rint);
Tov=N1/Fd;
F1=50;
dF=1/Tov;
F(i)=i*dF;
j=1:1:N1;
SpectrRint=fft(Rint);

figure;
plot(abs(SpectrRint(j)));
figure;
plot(Time,real(ifft(SpectrRint)));

for i=1:1:(N1+1)/2
    if i<50
        SpectrRint(i)=0;
        SpectrRint(N1-i+1)=0;
    end;
       % if i>10000 
        %SpectrRint(i)=0;
        %SpectrRint(N1-i+1)=0;
    %end;
    end;
    
Rintn=real(ifft(SpectrRint));

figure;
plot(Time,Rintn);

figure;
plot(abs(fft(Rintn)));

fname =['C:\Users\Дарина\Documents\GitHub\KursachSam\111.mat']; 
load(fname);
legh_fi=length(G)-1;
x=zeros([1,length(Rint)]);
y=zeros([1,length(Rint)]);
x=Rint;
%figure;
%plot(Time,x);
for k=1:legh_fi
for i=3:length(y)
y(i)=((SOS(k,4)*x(i)+SOS(k,5)*x(i-1)+SOS(k,6)*x(i-2))*(G(k))-(SOS(k,2)*y(i-1)+SOS(k,3)*y(i-2)))/SOS(k,1);
end;
for i=3:length(y)
x(i)=y(i);
end;
end;
Rintf=y;
%Rint=real(ifft(x));


FF10=fft(Rint,100);
b=length(FF);
%figure;
%plot(F,abs(FF10));
for i=1:1:(N+1)/2
    if F(i)<F1 
        FF(i)=0;
        FF(N-i)=0;
    end;
    end;
Rintn=real(ifft(FF));

figure;
plot(Time,Rintn);

Fy=fft(R);
F1=50/60; F2=90/60;
%figure;
%plot(F(j),abs(Fy(j)));

for i=1:1:(N+1)/2
    if F(i)<F1 
        Fy(i)=0;
        Fy(N-i)=0;
    end;
    if F(i)>F2 
        Fy(i)=0;
        Fy(N-i)=0;
    end;
    if F(i)>(F2-dF)
        if F(i)<(F2+dF)
            imax=i;
        end;
    end;
end;

j=1:1:imax;
y=real(ifft(Fy));

%figure;
%plot(Time,y);

i=1:1:N-1;
dy(i)=y(i+1)-y(i);

max=y(1);
temp=0; N1=0; xmax=0; ymax=0; Sum=0; s=0;
for i=1:1:N
    Sum=Sum+abs(y(i));
    if y(i)>max
        max=y(i);
        xmax=i;
        temp=0;
    else
        if temp==0
            if xmax>0
                if y(i)<max*0.5
                    N1=N1+1;
                    imax(N1)=xmax;
                    ym(N1)=max;
                    xm(N1)=Time(imax(N1));
                    yy(N1)=R(fix(xmax));
                    max=0.5*max;
                    temp=1;
                end
            end
            
        end
    end
end 

min=y(1);
temp=0; N2=0; xmin=0; ymin=0; Sum=0; s=0;
for i=1:1:N
    Sum=Sum+abs(y(i));
    if y(i)<min
        min=y(i);
        xmin=i;
        temp=0;
    else
        if temp==0
            if xmin>0
                if y(i)>min+50;
                    N2=N2+1;
                    imin(N2)=xmin;
                    ymi(N2)=min;
                    xmi(N2)=Time(imin(N2));
                    yyy(N2)=R(fix(xmin));
                    min=min+50;
                    temp=1;
                end
            end
            
        end
    end
end 

k=1;n=1;
for i=1:N1
    if k<=N2
        if imin(i)>imax(k)
            %cycleb(n) = fminbnd('R',imax(i),imin(k));
            period(n) = imin(i);
            min = R(period(n));
            RRR(n) = min;
            for j=imin(k):imax(i)
                if min>R(j)
                    period(n)=j;
                    min = R(j);
                    RRR(n) = min;
                end
            end               
            n=n+1;
            k=k+1;
        end
    end
end

i = 1:N;

%figure;
%plot(Time,R,xm,yy,'ko',xmi,yyy,'ko');
%figure;
%plot(i,R,period,RRR,'ko');
