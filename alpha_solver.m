clc; clear; close all;

% Given Specifications
Vrms=240; Vm=Vrms*sqrt(2);
f=50; w=2*pi*f; P_desired=2000;
% RL Selection
R=18; L=0.231;

% To be plotted as x-axis
alpha_max=atand(w*L/R); % Continuous
alpha=[0:0.01:alpha_max];

% Fundamental Harmonic
V0=2*Vm/pi*cosd(alpha);
I0=V0./R;
% Second Harmonic
n=2;
a2=2*Vm/pi*(cosd((n+1).*alpha)/(n+1) - cosd((n-1).*alpha)/(n-1));
b2=2*Vm/pi*(sind((n+1).*alpha)/(n+1) - sind((n-1).*alpha)/(n-1));
V2=sqrt(a2.^2 + b2.^2); Z2=sqrt(R^2 + (2*w*L)^2);
I2=V2./Z2;
% Fourth Harmonic
n=4;
a4=2*Vm/pi*(cosd((n+1).*alpha)/(n+1) - cosd((n-1).*alpha)/(n-1));
b4=2*Vm/pi*(sind((n+1).*alpha)/(n+1) - sind((n-1).*alpha)/(n-1));
V4=sqrt(a4.^2 + b4.^2); Z4=sqrt(R^2 + (4*w*L)^2);
I4=V4./Z4;

% Compute power to be plotted on y-axis
Irms=sqrt(I0.^2 + (I2./sqrt(2)).^2 + (I4./sqrt(2)).^2);
P=Irms.^2.*R;

% Search for P=2kW
not_found=1;
for k=1:1:length(P)
  if P(k)-P_desired <=0
    alpha_ans=alpha(k)
    not_found=0;
    printf('Average Voltage, V0 = %.2f\n', V0(k))
    printf('Average Current, I0 = %.2f\n', I0(k))
    printf('RMS Current, Irms = %.2f\n', Irms(k))
    printf('Average Power = %.2f\n',P(k))
    break;
  endif
endfor

if not_found
  disp('Not found! Maybe try changing R or L.');
else
  % Plot P vs alpha graph
  plot(alpha,P); grid on;
  xlabel('\alpha'); xticks([0:5:80]);
  ylabel('P (W)'); hold on;
  % Plot the point when P=2kW
  plot(alpha(k),P(k),'r*')
endif
