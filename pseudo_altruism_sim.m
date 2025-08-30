% --- 实验六：“伪利他”行为的临界点模拟 ---
clear; clc; close all;

% 1. 定义囚徒困境收益矩阵
R = 3;  % 双方合作 (Reward)
S = 0;  % 被背叛 (Sucker)
P = 1;  % 双方背叛 (Punishment)

% 我们将改变背叛的诱惑值 T 来观察其影响
T_values = 3.1:0.2:7; % T > R

% 2. 计算决策临界点 gamma_threshold
% EU_Cooperate = R / (1-gamma)
% EU_Defect = T + P*gamma / (1-gamma)
% 求解 R/(1-g) = T + P*g/(1-g)  =>  R = T(1-g) + P*g
% R = T - T*g + P*g  =>  g(T-P) = T-R  =>  g = (T-R)/(T-P)
gamma_thresholds = (T_values - R) ./ (T_values - P);

% 3. 可视化
figure;
plot(T_values, gamma_thresholds, 'r-s', 'LineWidth', 2, 'MarkerFaceColor', 'y');
grid on;
title('“利他”决策与未来收益的重视程度', 'FontSize', 14);
xlabel('背叛的诱惑值 (T)', 'FontSize', 12);
ylabel('合作所需的最低未来贴现因子 (\gamma_{threshold})', 'FontSize', 12);
ylim([0, 1]);

text(5, 0.6, {'\gamma > \gamma_{threshold}: 选择合作 (表现为利他)', ...
              '\gamma < \gamma_{threshold}: 选择背叛 (表现为利己)'}, ...
              'BackgroundColor', 'white', 'EdgeColor', 'black');

fprintf('结论: 背叛的短期诱惑(T)越大,\n');
fprintf('个体需要对未来有更高的重视程度(\gamma)才会选择合作。\n');
