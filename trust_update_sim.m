% --- 实验二：信任的贝叶斯更新模拟 ---
clear; clc; close all;

% 1. 定义模型参数 (似然度)
H1 = '是合作者'; H0 = '是背叛者';
P_cooperate_given_H1 = 0.99; % P(合作|合作者)
P_defect_given_H1    = 1 - P_cooperate_given_H1;

P_cooperate_given_H0 = 0.5;  % P(合作|背叛者) - 伪装
P_defect_given_H0    = 1 - P_cooperate_given_H0;

% 2. 模拟交互序列
events = {'合作', '合作', '合作', '合作', '合作', '背叛', '合作', '合作'};
num_events = length(events);

% 3. 初始化并进行贝叶斯更新
P_H1_history = zeros(1, num_events + 1);
P_H1 = 0.5; % 初始信任度 (先验概率)
P_H1_history(1) = P_H1;

for i = 1:num_events
    event = events{i};
    P_H0 = 1 - P_H1;
    
    if strcmp(event, '合作')
        likelihood_H1 = P_cooperate_given_H1;
        likelihood_H0 = P_cooperate_given_H0;
    else % 背叛
        likelihood_H1 = P_defect_given_H1;
        likelihood_H0 = P_defect_given_H0;
    end
    
    % 贝叶斯更新
    numerator = likelihood_H1 * P_H1;
    denominator = likelihood_H1 * P_H1 + likelihood_H0 * P_H0;
    P_H1 = numerator / denominator; % 更新后的信任度 (后验概率)
    
    P_H1_history(i+1) = P_H1;
end

% 4. 可视化
figure;
plot(0:num_events, P_H1_history, 'o-', 'LineWidth', 2, 'MarkerSize', 8);
grid on;
title('信任的贝叶斯更新过程', 'FontSize', 14);
xlabel('交互次数', 'FontSize', 12);
ylabel('信任度 P(对方是合作者)', 'FontSize', 12);
xticks(0:num_events);
xticklabels(['初始', events]);
xtickangle(45);
ylim([0, 1]);

% 在图上标注事件
for i = 1:num_events
    text(i, P_H1_history(i+1) + 0.05, events{i}, 'HorizontalAlignment', 'center');
end

fprintf('初始信任度: %.2f\n', P_H1_history(1));
fprintf('最终信任度: %.2f\n', P_H1_history(end));
