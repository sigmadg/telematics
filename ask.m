clear; close all; clc;
%% % Señal modulada

fm=0.5; fy=10; q=10; Ac=1; As=1; Am=1; 
tiempo=linspace(0,q,10000);

% Señal moduladora
x=(2*pi*tiempo*fm); s=sin(x); SModuladora=Am*s; ab=(-SModuladora);
% Señal portadora
y=(2*pi*tiempo*fy); SModuladora2=sin(y);
% Señal Ask
u=As/2.*square(x)+(As/2);

v=SModuladora2.*u;
am=As*Ac*SModuladora2.*SModuladora; 
ask1= As*Ac*v.*SModuladora; 

figure(1)
subplot(3,1,1);
plot(tiempo,SModuladora2, 'b')
ylabel('Amplitud');xlabel('Segundos');title('Señal portadora');  axis ([0 10 -1.5 1.5]);

subplot(3,1,2);
plot(tiempo,u, 'r')
ylabel('Amplitud');xlabel('Segundos');title('Señal moduladora'); axis ([0 10 -1.5 1.5]);

subplot(3,1,3);
plot(tiempo, v)
ylabel('Amplitud');xlabel('Segundos');title('Señal modulada'); axis ([0 10 -1.5 1.5]);
