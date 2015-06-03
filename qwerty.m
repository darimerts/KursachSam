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

temp=0; aa=0; bb=-2/35*100000;
for i=1:1:N
    temp=temp+R(i);
    ssss(i)=temp;
    sss(i)=ssss(i)-(aa+bb*Time(i));
end


%����� �������
figure;
plot(Time,sss);

FF=fft(sss);
kk=1:1:N;
Tov=N/Fd;
dF=1/Tov;
F(kk)=kk*dF;

%figure;
%plot(F(kk),abs(FF(kk)));

FF1=50/60; FF2=70/60;
for k=1:1:(N+1)/2
    if F(k)<FF1 
        FF(k)=0;
        FF(N-k+1)=0;
    end;
    if F(k)>FF2 
        FF(k)=0;
        FF(N-k+1)=0;
    end;
end;




%figure;
%plot(F(kk),abs(FF(kk)));

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

