clc;
clear all
t=1:600;
A=0.25;
B=1.25;
f1=0.5;
f2=0.025;
s=A*sin(f1*t)+B*cos(f2*t)+randn(size(t));
y=tarekLPF(s,10,270);
plot(t,s,'b',t,y,'r','LineWidth',2)
legend('original','filtred')