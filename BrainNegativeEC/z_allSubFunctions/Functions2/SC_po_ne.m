% 假设原始矩阵为 A，大小为 90x90
close all
clear all
load  SC_aditer.mat
A = SC_aditer;
% 将 A 中的负数置零，得到 C1
C1 = A;
C1(C1 < 0) = 0;

% 将 A 中的正数置零，得到 C2
C2 = A;
C2(C2 > 0) = 0;
C2 = abs(C2);
C3 = C2;
C3(C3<0.005) = 0;

% 显示 C1 的立体形式
figure('Color',[1 1 1]);
[X, Y] = meshgrid(1:90, 1:90);
%surf(X, Y, C1);
bar3(C1);
title('C1 (all positive)');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Values');
figure('Color',[1 1 1]);
imagesc(C1);colorbar;
%colormap('viridis');

% 显示 C2 的立体形式
figure('Color',[1 1 1]);
%surf(X, Y, C2);
bar3(C2);
title('C2 (all negative)');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Values');
%colormap('viridis');
figure('Color',[1 1 1]);
imagesc(C2);colorbar;
figure('Color',[1 1 1]);
%surf(X, Y, C2);
bar3(C3);
title('C3 (C2>0.005)');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Values');
zlim([0,0.02]);
figure('Color',[1 1 1]);
imagesc(C3);colorbar;
