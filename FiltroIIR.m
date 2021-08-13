close all;
clear all;
clc;

n = 6;
f = 2e9;

[zb,pb,kb] = butter(n,2*pi*f,'s');
[bb,ab] = zp2tf(zb,pb,kb);
[hb,wb] = freqs(bb,ab,4096);

[z1,p1,k1] = cheby1(n,3,2*pi*f,'s');
[b1,a1] = zp2tf(z1,p1,k1);
[h1,w1] = freqs(b1,a1,4096);

[z2,p2,k2] = cheby2(n,30,2*pi*f,'s');
[b2,a2] = zp2tf(z2,p2,k2);
[h2,w2] = freqs(b2,a2,4096);

[ze,pe,ke] = ellip(n,3,30,2*pi*f,'s');
[be,ae] = zp2tf(ze,pe,ke);
[he,we] = freqs(be,ae,4096);

plot(wb/(2e9*pi),mag2db(abs(hb)))
hold on
plot(w1/(2e9*pi),mag2db(abs(h1)))
plot(w2/(2e9*pi),mag2db(abs(h2)))
plot(we/(2e9*pi),mag2db(abs(he)))
axis([0 4 -40 5])
grid
xlabel('Frecuencia (GHz)')
ylabel('Atenuación (dB)')
legend('Butterworth','Chebyshev Tipo 1','Chebyshev Tipo 2','Elliptic')

%Simulación de coeficientes:

%**********Diseño del filtro**********
[N,Wn]=buttord(1500/(8000/2), 1700/(8000/2), 0.5, 60); %Nos dá el orden y frec. De corte del filtro
%[num,den]=butter(12,1500/4000); %Calcula los coeficientes del numerador y denominador del filtro.
[num,den]=butter(N,Wn);
w=0:pi/255:pi; %Hacemos variar la frecuencia entre 0 y pi. Barrido
figure(2)
Hlp=freqz(num,den,w); %Calcula la respuesta en frecuencia del filtro para ls Fs elegida.
semilogy(w/pi,abs(Hlp)) %Escala logaritmica de amplitud
grid
H = 20*log10(abs(Hlp));
figure(4)
plot(w/pi,H)
axis([0 1 -60 5]);
ylabel('Ganancia en dB');
xlabel('Frecuencia normalizada: w/pi');
pause;
%**********Simulación del diseño*********
%Definicion frec. de muestreo y barrido temporal para las señales a simular
fm = 8000;
tm = inv(fm);
N = 8000;
t = 0:tm:tm*(N-1);
x=sin(2*pi*2000*t); % Crea la señal de entrada del tipo sinosoidal de 1000Hz
xr=sin(2*pi*1000*t); % Crea la señal de entrada del tipo sinosoidal de 2000Hz
y=x+xr; %Señal suma de senoides del problema
subplot(311)
plot(t,y) %Dibuja Señal original
%Para Calculo FFT
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
Y = fft(y,NFFT)/N;
f = fm/2*linspace(0,1,NFFT/2+1);
subplot(312)
plot(f,2*abs(Y(1:NFFT/2+1))) % Muestra la FFT de la señal de entrada
title('Espectro de Amplitud y(t)')
xlabel('Frecuencia (Hz)')
ylabel('|Y(f)|')
pause;
figure(5);
Sal=filter(num,den,y) %Aplica el filtro diseñado a la señal de prueba.
plot(t,Sal) %Muestra la señal Filtrada en el tiempoyew
figure(6)
F = fft(Sal,NFFT)/N; %Muestra el contenido frecuencial de la señal Filtrada.
plot(f,2*abs(F(1:NFFT/2+1)))
xlabel('f (Hz)SALIDA');
ylabel('Amplitud SALIDA');
