% --- 实验三：交互式马克思-贝叶斯风险阈值 ---
function marx_bayes_interactive()
    % 创建图形窗口
    fig = figure('Name', 'Marx-Bayes Threshold Explorer', 'Position', [200, 200, 700, 600]);

    % 创建绘图区域
    ax = axes('Parent', fig, 'Position', [0.1, 0.3, 0.8, 0.6]);
    
    % 创建滑块和标签
    % 惩罚成本 C 的滑块
    uicontrol('Style', 'text', 'Position', [50, 70, 150, 20], 'String', '惩罚成本 (C)');
    slider_C = uicontrol('Style', 'slider', 'Min', 1, 'Max', 100, 'Value', 10, ...
                         'Position', [200, 70, 300, 20], 'Callback', @update_plot);
    text_C = uicontrol('Style', 'text', 'Position', [520, 70, 50, 20], 'String', '10');

    % 主观失败概率 p 的滑块 (注意 p 不能为1)
    uicontrol('Style', 'text', 'Position', [50, 30, 150, 20], 'String', '主观失败概率 (p)');
    slider_p = uicontrol('Style', 'slider', 'Min', 0.01, 'Max', 0.99, 'Value', 0.5, ...
                         'Position', [200, 30, 300, 20], 'Callback', @update_plot);
    text_p = uicontrol('Style', 'text', 'Position', [520, 30, 50, 20], 'String', '0.50');
    
    % 初始化绘图
    update_plot();

    % --- 回调函数：当滑块移动时更新绘图 ---
    function update_plot(~, ~)
        % 获取滑块的当前值
        C = get(slider_C, 'Value');
        p_subjective = get(slider_p, 'Value');
        
        % 更新滑块旁边的文本
        set(text_C, 'String', sprintf('%.1f', C));
        set(text_p, 'String', sprintf('%.2f', p_subjective));
        
        % 重新计算曲线
        p_vec = 0.01:0.01:0.99;
        R_T = (p_vec ./ (1 - p_vec)) .* C;
        
        % 绘制曲线
        plot(ax, p_vec, R_T, 'b-', 'LineWidth', 2);
        hold(ax, 'on');
        
        % 标记用户选择的点
        R_T_subjective = (p_subjective / (1 - p_subjective)) * C;
        plot(ax, p_subjective, R_T_subjective, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
        
        % 设置图形属性
        grid(ax, 'on');
        title(ax, '回报阈值 vs. 失败概率', 'FontSize', 14);
        xlabel(ax, '失败概率 (p)', 'FontSize', 12);
        ylabel(ax, '所需回报阈值 (R_T)', 'FontSize', 12);
        legend(ax, {sprintf('曲线 (C = %.1f)', C), '你的主观评估点'}, 'Location', 'northwest');
        ylim(ax, [0, max(R_T)*1.1]);
        hold(ax, 'off');
    end
end
