% --- 实验五：电车难题决策边界地图 ---
clear; clc; close all;

% 1. 定义参数空间
social_weights = 0:0.02:1;      % X轴: 对社会秩序的重视程度
responsibility_aversions = 0:0.02:1; % Y轴: 对个人责任的规避程度

[X, Y] = meshgrid(social_weights, responsibility_aversions);

% 2. 风险函数建模
Base_Risk_Social_Collapse = 0.8; % 基础社会崩溃风险(抽象值)
Base_Risk_Direct_Punishment = 1.0; % 基础直接惩罚风险(抽象值)

% 计算在参数空间每个点的风险
Risk_N = X .* Base_Risk_Social_Collapse; % 不干预的风险
Risk_I = Y .* Base_Risk_Direct_Punishment; % 干预的风险

% 3. 生成决策矩阵
% Decision = 1  => 选择干预 (Intervene)
% Decision = -1 => 选择不干预 (Do Nothing)
Decision_Matrix = sign(Risk_N - Risk_I);
% 处理 Risk_N == Risk_I 的情况，将其归为不干预
Decision_Matrix(Decision_Matrix == 0) = -1;

% 4. 可视化决策地图
figure;
contourf(X, Y, Decision_Matrix, [-1, 1], 'LineWidth', 1.5);
colormap([0.8 0.2 0.2; 0.2 0.8 0.2]); % 红/绿

colorbar('Ticks', [-1, 1], 'TickLabels', {'不干预', '干预'});
title('电车难题决策地图', 'FontSize', 16);
xlabel('对社会秩序的重视程度', 'FontSize', 12);
ylabel('对个人责任的规避程度', 'FontSize', 12);
axis square;
grid on;

% 添加几个决策者画像示例
hold on;
plot(0.8, 0.2, 'wo', 'MarkerSize', 10, 'MarkerFaceColor', 'w');
text(0.8, 0.15, '康德主义者', 'Color', 'w', 'HorizontalAlignment', 'center');

plot(0.2, 0.9, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
text(0.2, 0.85, '绝对利己主义者', 'Color', 'k', 'HorizontalAlignment', 'center');

plot(0.7, 0.75, 'yo', 'MarkerSize', 10, 'MarkerFaceColor', 'y');
text(0.7, 0.8, '功利主义者 (计算中)', 'Color', 'k', 'HorizontalAlignment', 'center');
hold off;
