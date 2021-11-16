
clc; clear; close all;

x=[ 1 0 0 1 1 0 1]; bp=.000001;                                          
disp(' Información transmitida :');
disp(x);

bit=[]; 
for n=1:1:length(x)
    if x(n)==1;
       se=ones(1,100);
    else x(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];
end

t1=bp/100:bp/100:100*length(x)*(bp/100);
subplot(3,1,1);
plot(t1,bit,'red');grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('Amplitud');
xlabel('Tiempo');
title('Información digital transmitida');

A=5; br=1/bp; f=br*2; t2=bp/99:bp/99:bp; ss=length(t2);
m=[];
for (i=1:1:length(x))
    if (x(i)==1)
        y=A*cos(2*pi*f*t2);
    else
        y=A*cos(2*pi*f*t2+pi);  
    end
    m=[m y];
end

t3=bp/99:bp/99:bp*length(x);

subplot(3,1,2);
plot(t3,m);
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal modulada');

mn=[];
for n=ss:ss:length(m)
  t=bp/99:bp/99:bp;
  y=cos(2*pi*f*t);
  mm=y.*m((n-(ss-1)):n);
  t4=bp/99:bp/99:bp;
  z=trapz(t4,mm)  
  zz=round((2*z/bp)) 
  
  if(zz>0)          
    a=1;
  else
    a=0;
  end
  mn=[mn a];
end
disp(' Información recibida :');
disp(mn);

bit=[];
for n=1:length(mn);
    if mn(n)==1;
       se=ones(1,100);
    else mn(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];
end

t4=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(3,1,3)
plot(t4,bit,'red');grid on;
axis([ 0 bp*length(mn) -.5 1.5]);
ylabel('Amplitud');
xlabel('Tiempo');
title('Información digital recibida');