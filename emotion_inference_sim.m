% --- 实验四：情感的贝叶斯推断模拟 ---
clear; clc; close all;

% 1. 参数定义
P_H_prior = 0.1; % 自己未来遭遇不幸的先验概率
P_S_prior = 0.3; % 自己未来获得成功的先验概率

% 定义不同相似度的观察对象
similarities = 0.1:0.2:0.9; % 从“陌生人”到“挚友/兄弟”
num_levels = length(similarities);

% 初始化情感强度记录
empathy_strength = zeros(1, num_levels);
congrats_strength = zeros(1, num_levels);

% 2. 模拟更新过程
for i = 1:num_levels
    sim = similarities(i);
    
    % --- 模拟共情 (Empathy) ---
    % 似然度建模: P(观察到他人不幸 | H=自己未来会不幸)
    % 相似度越高，这个证据越强
    likelihood_H1 = 0.2 + sim * 0.7; % P(E_neg|H_self)
    likelihood_H0 = 0.1;             % P(E_neg|~H_self) - 基础不幸事件发生率
    
    % 贝叶斯更新
    numerator_H = likelihood_H1 * P_H_prior;
    denominator_H = numerator_H + likelihood_H0 * (1 - P_H_prior);
    P_H_posterior = numerator_H / denominator_H;
    
    % 量化情感强度
    empathy_strength(i) = P_H_posterior - P_H_prior;
    
    % --- 模拟祝贺 (Congratulating) ---
    % 似然度建模: P(观察到他人成功 | S=自己未来会成功)
    likelihood_S1 = 0.2 + sim * 0.6; % P(E_pos|S_self)
    likelihood_S0 = 0.15;            % P(E_pos|~S_self) - 基础成功事件发生率
    
    % 贝叶斯更新
    numerator_S = likelihood_S1 * P_S_prior;
    denominator_S = numerator_S + likelihood_S0 * (1 - P_S_prior);
    P_S_posterior = numerator_S / denominator_S;
    
    % 量化情感强度
    congrats_strength(i) = P_S_posterior - P_S_prior;
end

% 3. 可视化
figure;
subplot(1, 2, 1);
bar(similarities, empathy_strength, 'FaceColor', '#0072BD');
title('共情强度 vs. 观察对象相似度', 'FontSize', 12);
xlabel('与观察对象的相似度', 'FontSize', 10);
ylabel('自身不幸概率的增量 ΔP(H)', 'FontSize', 10);
grid on;

subplot(1, 2, 2);
bar(similarities, congrats_strength, 'FaceColor', '#D95319');
title('祝贺强度 vs. 观察对象相似度', 'FontSize', 12);
xlabel('与观察对象的相似度', 'FontSize', 10);
ylabel('自身成功概率的增量 ΔP(S)', 'FontSize', 10);
grid on;

sgtitle('情感作为贝叶斯推断的模拟', 'FontSize', 16, 'FontWeight', 'bold');
