clear,clc;
load(".\data\KA03\KA03\N09_M07_F10_KA03_1.mat");
load(".\data\K001\K001\N09_M07_F10_K001_2.mat");
load(".\data\KB23\KB23\N09_M07_F10_KB23_1.mat");
load(".\data\KI14\KI14\N09_M07_F10_KI14_1.mat");
load(".\data\KI01\KI01\N09_M07_F10_KI01_5.mat");

fs = 64e3;  % Sampling frequency
T = 1/fs;   % Sampling period     
lowpassF = 5e3; % lowpass frequency

ogData = N09_M07_F10_KB23_1.Y; % data

rpm = ogData(4).Data;          % rpm data
testdata = ogData(end).Data;   % viberation data
% subplot(121);plot(testdata);
testdata = detrend(testdata);
% subplot(122);plot(testdata);
% �˲���һ��ʼ�ɲ�ѡ�񣬺�ѡ����ʵ��˲���֮���ٽ����˲�
testdata = lowpass(testdata,lowpassF,fs);  %��ͨ�˲���ʹ��Ч������
% ���Ͷȷ������õ����ʵĴ�ͨ�˲����ٽ��а���
% level = 9;
% [~, ~, ~, fc, ~, BW] = kurtogram(testdata, fs, level);

%%% ���
[t,data,f,Fx,h_x,H_X] = fftandHfft(testdata,64e3);

% ��ͨ�˲�
% [H_X, f, xEnvOuterBpf, tEnvBpfOuter] = envspectrum(testdata, fs, ...
%  'FilterOrder', 200, 'Band', [fc-BW/2 fc+BW/2]);

%%% �����������Ƶ��
D=29.05;
d=6.75;
fr=mean(rpm)/60;  %��ƽ��ת�ٽ��з���
z=8;                              %���Ӹ���
alpha=0;
bpfo = 0.5*z*fr*(1-d/D*cos(alpha));
bpfi = 0.5*z*fr*(1+d/D*cos(alpha));
bsf = 0.5*D/d*fr*(1-(d/D)^2*(cos(alpha))^2); 
ftf = 0.5*fr*(1-d/D*cos(alpha));

%%% ��ͼ�������Լ���������Ƶ�ʶԱ���
figure();
plot(f,H_X);hold on;
for i=1:10
    hold on;plot([bpfo*i,bpfo*i],[0,max(H_X)],'--b');
    hold on;plot([bpfi *i,bpfi*i],[0,max(H_X)],'--m');
%      hold on;plot([bsf*i,bsf*i],[0,max(H_X)],'--r');
%      hold on;plot([ftf*i,ftf*i],[0,max(H_X)],'--k');
end
title('Hilbert & Furier transfrom'),xlabel('Frequcy(Hz)'),ylabel('Amplitude');
xlim([0,500]);
legend('x(f)','BPFO','BPFI');
% legend('x(f)','BSF','FTF');