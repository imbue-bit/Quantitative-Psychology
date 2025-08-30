% --- 实验一：旁观者效应模拟 ---
clear; clc; close all;

% 1. 参数定义
N_range = 1:100; % 旁观者人数范围
C_total = 10;    % 不干预造成的社会总风险增量 (一个抽象值)
U_safe_A1 = 0.95;% 干预行为带来的未来安全效用 (干预本身有成本/风险)

% 2. 计算期望效用
% 个体分摊的风险 E(C_individual) = C_total / N
% 这里我们简化，认为风险直接降低了未来安全的概率
P_danger_A0 = C_total ./ N_range;
% 确保概率不为负
P_danger_A0(P_danger_A0 > 1) = 1; 

% 不干预(A0)后，未来安全的概率
P_safe_A0 = 1 - P_danger_A0;

% 不干预的期望效用 EU(A0) = P_safe_A0 * 1 + P_danger_A0 * 0
EU_A0 = P_safe_A0;

% 干预(A1)的期望效用 EU(A1) 是一个固定的值
EU_A1 = ones(1, length(N_range)) * U_safe_A1;

% 3. 找到决策拐点
% 寻找 EU_A0 > EU_A1 的第一个点
crossover_idx = find(EU_A0 > U_safe_A1, 1);
if ~isempty(crossover_idx)
    crossover_N = N_range(crossover_idx);
    fprintf('决策拐点：当旁观者人数达到 %d 时，个体开始倾向于不干预。\n', crossover_N);
end

% 4. 可视化
figure;
plot(N_range, EU_A0, 'b-', 'LineWidth', 2, 'DisplayName', 'EU(不干预)');
hold on;
plot(N_range, EU_A1, 'r--', 'LineWidth', 2, 'DisplayName', 'EU(干预)');
if ~isempty(crossover_idx)
    plot(crossover_N, EU_A0(crossover_idx), 'kp', 'MarkerSize', 12, ...
    'MarkerFaceColor', 'yellow', 'DisplayName', '决策拐点');
end
grid on;
hold off;

title('旁观者效应决策模型', 'FontSize', 14);
xlabel('旁观者人数 (N)', 'FontSize', 12);
ylabel('期望未来安全效用 (EU)', 'FontSize', 12);
legend('show', 'Location', 'southeast');
ylim([0, 1.1]);
