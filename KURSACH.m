close all
clear all

%��������� ���� � ��������� �������
fileID = fopen('���_1.txt','r');
formatSpec = '%d';
A = fscanf(fileID,formatSpec);
fclose(fileID);

%������� ������� � ���������
N = length(A);
i = 1:N;
Fd = 200;
Time = i/Fd;
U = A/(10^3);
I = 1/(10^3);
R = U/I;
Rdif=-R;

figure;
plot(Time,Rdif);
legend('���������������� ���');
xlabel('�����'); 
ylabel('�������������');

temp=0; aa=0; bb=-2/35*100000;
for i=1:1:N
    temp=temp+Rdif(i);
    Reo(i)=temp;
 end

figure;
plot(Time,Reo);
legend('���');
xlabel('�����'); 
ylabel('�������������');

%������� �������� �����

detrend_Reo=detrend(Reo,8);
trend=Reo-detrend_Reo;

%������� �������������� �����(������ �� ������� �������� ������, ������ 
%����������, ��������� �� ���?
x = Time;
y = Reo; 

[p,s,mu] = polyfit(x,y,40);
trend1=polyval(p,Time,[],mu);
detrend_Reo1=Reo-trend1;

%�������� ������������� ������
%Time_middle=sym(Time(i))/N;
%Reo_middle=sym(Reo(i))/N;
%b=(sum(Time(i)*Reo(i))+N*Time_middle*Reo_middle)/(sum(Time(i)*Time(i))+N*Time_middle*Time_middle);
%a=Reo_middle/(b*Time_middle);
%Regres(i)=b*Time(i)+a;
%disp(b);
%disp(a);

%�������� ������������� ������(������ 1)

%Regres1=5503*Time+3.201*10^4;

%����� ��� � �������/��� �����/������ ������/������������� ������ � �.�.

figure;
plot(Time,Reo);

hold on;
plot(Time,trend,':r');

hold on;
plot(Time,detrend_Reo,'m');

hold on;
plot(Time,trend1,':c');

hold on;
plot(Time,detrend_Reo1,'y');

%hold on;
%plot(Time,trend1,':r');

%hold on;
%plot(Time,detrend_Reo1,'m');


%hold on;
%plot(Time,Regres,'c');

%hold on;
%plot(Time,Regres1,'y');

legend('��� � �������','�����','��� ��� ��������� ������','�����1','��� ��� ��������������� ������');
xlabel('�����'); 
ylabel('�������������');

%������ ��� ��� ������(���.���������)
FF=fft(detrend_Reo);
kk=1:1:N;
Tov=N/Fd;
dF=1/Tov;
F(kk)=kk*dF;

%���������� �������
figure;
plot(F(kk),abs(FF(kk)));

%������ ��� � �������
FF10=fft(Reo);
kk=1:1:N;
Tov=N/Fd;
dF=1/Tov;
F(kk)=kk*dF;

%���������� �������
figure;
plot(F(kk),abs(FF10(kk)));

%������ ��� ��� ������(�������������� ���������)
FF11=fft(detrend_Reo1);
kk=1:1:N;
Tov=N/Fd;
dF=1/Tov;
F(kk)=kk*dF;

%���������� �������
figure;
plot(F(kk),abs(FF11(kk)));




FF1=18/60; FF2=30;
for k=1:1:(N+1)/2
    if F(k)<FF1 
        FF10(k)=0;
        FF10(N-k+1)=0;
        end;
        if F(k)>FF2 
        FF11(k)=0;
        FF11(N-k+1)=0;
    end;
end;

yy=real(ifft(FF10));
figure;
plot(kk,yy);

FF1=18/60; FF2=30;
for k=1:1:(N+1)/2
    if F(k)<FF1 
        FF11(k)=0;
        FF11(N-k+1)=0;
        end;
        if F(k)>FF2 
        FF11(k)=0;
        FF11(N-k+1)=0;
    end;
end;

yy=real(ifft(FF11));
figure;
plot(kk,yy);


yy=real(ifft(FF));
figure;
plot(kk,yy);

Fy=fft(R);
F1=40/60; F2=90/60;

j=1:1:N/2;
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

%j=1:1:imax;
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
figure;
plot(i,R,period,RRR,'ko');