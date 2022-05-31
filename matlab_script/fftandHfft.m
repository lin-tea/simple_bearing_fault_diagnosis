function [t,data,f,Fx,h_x,H_X] = fftandHfft(data,Fs)
% �������ݣ���������ͼ������Ҷ�任�����磬Hllber��ͼ
% Args: 
%   [1] Fs: ������
% ���:
%   t:��ʵʱ������
%   data:����
%   f:Ƶ��
%   Fx:����Ҷ��
%   h_x:Hilbert����
%   H_X:Hilbert������                
    T = 1/Fs;             % Sampling period       
    L = length(data);             % Length of signal
    t = (0:L-1)*T;        % Time vector
    f = Fs*(0:int32(L/2))/L;   % 1/2 Sampling frequency
    %fft  ��ԭʼ�źŽ��и���Ҷ�任
    Fx = fft(data);
    Fx = abs(Fx/L);
    Fx = Fx(1:int32(L/2+1)); 
    Fx(2:end-1) = 2*Fx(2:end-1);
    % Hilbert and fft ��ԭʼ�źŽ���Hilbert���� ���ҽ��и���Ҷ�任
    h_x = hilbert(data); %Hilbert
    h_x = abs(h_x);    %ȡ����ֵ
    h_x = h_x - mean(h_x);  %��ȥ��ֵ
    %���и���Ҷ�任
    H_X = abs(fft(h_x)/L);  
    H_X = H_X(1:int32(L/2+1));
    H_X(2:end-1) = 2*H_X(2:end-1);
    %plot  �������
    figure();
    subplot(4,1,1),plot(t,data),title('Origin data'),xlabel('t/s'),ylabel('Amplitude');
    subplot(4,1,2),plot(f,Fx);
    title('Furier transfrom'),xlabel('Frequcy(Hz)'),ylabel('Amplitude');
    % x�᷶Χ
%     xlim([0,1000]);
    legend('x(f)');
    subplot(4,1,3),plot(t,h_x),title('Hilbert'),xlabel('t/s'),ylabel('Amplitude');
    subplot(4,1,4);
    plot(f,H_X);
    title('Hilbert & Furier transfrom'),xlabel('Frequcy(Hz)'),ylabel('Amplitude');
    xlim([0,500]);
    legend('x(f)');
end