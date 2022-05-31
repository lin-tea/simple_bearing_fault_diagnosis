function [t,data,f,Fx,h_x,H_X] = fftandHfft(data,Fs)
% 根据数据，画出数据图，傅里叶变换，包络，Hllber谱图
% Args: 
%   [1] Fs: 采样率
% 输出:
%   t:真实时间序列
%   data:数据
%   f:频率
%   Fx:傅里叶谱
%   h_x:Hilbert包络
%   H_X:Hilbert包络谱                
    T = 1/Fs;             % Sampling period       
    L = length(data);             % Length of signal
    t = (0:L-1)*T;        % Time vector
    f = Fs*(0:int32(L/2))/L;   % 1/2 Sampling frequency
    %fft  对原始信号进行傅里叶变换
    Fx = fft(data);
    Fx = abs(Fx/L);
    Fx = Fx(1:int32(L/2+1)); 
    Fx(2:end-1) = 2*Fx(2:end-1);
    % Hilbert and fft 对原始信号进行Hilbert包络 并且进行傅里叶变换
    h_x = hilbert(data); %Hilbert
    h_x = abs(h_x);    %取绝对值
    h_x = h_x - mean(h_x);  %减去均值
    %进行傅里叶变换
    H_X = abs(fft(h_x)/L);  
    H_X = H_X(1:int32(L/2+1));
    H_X(2:end-1) = 2*H_X(2:end-1);
    %plot  画出结果
    figure();
    subplot(4,1,1),plot(t,data),title('Origin data'),xlabel('t/s'),ylabel('Amplitude');
    subplot(4,1,2),plot(f,Fx);
    title('Furier transfrom'),xlabel('Frequcy(Hz)'),ylabel('Amplitude');
    % x轴范围
%     xlim([0,1000]);
    legend('x(f)');
    subplot(4,1,3),plot(t,h_x),title('Hilbert'),xlabel('t/s'),ylabel('Amplitude');
    subplot(4,1,4);
    plot(f,H_X);
    title('Hilbert & Furier transfrom'),xlabel('Frequcy(Hz)'),ylabel('Amplitude');
    xlim([0,500]);
    legend('x(f)');
end