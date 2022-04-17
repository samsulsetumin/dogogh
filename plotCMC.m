function [h] = plotCMC(ranks, results, legendName, marker, figNum)
%plotCMC Summary of this function goes here
%   Detailed explanation goes here

    %h = semilogx(ranks,results);
    %h = plot(ranks,results);
    %h = loglog(ranks,results);
%     h = stairs(ranks, results); % Not Working
%     hold on
    
    % Alternative solution for stairs
%     xi = linspace(min(ranks), max(ranks), length(ranks)*10);
%     yi = interp1(ranks, results, xi, 'nearest');
%     figure(1); hold on
%     if nargin > 3
%         plot(xi, yi, marker,'LineWidth', 2,'DisplayName',legendName);
%     else
%         plot(xi, yi,'LineWidth', 2,'DisplayName',legendName);
%     end

    figure(figNum); hold on
    if nargin > 3
        plot(ranks, results, marker,'LineWidth', 2,'DisplayName',legendName);
    else
        plot(ranks, results,'LineWidth', 2,'DisplayName',legendName);
    end
    
    %axis labels
    xlabel('Rank')
    ylabel('Retrieval Rate')

    %grid lines 
    max_x = numel(results);
    axis([1 max_x 0 100]);
    
    legend(gca,'off');
    legend(gca,'toggle');
    grid off
    grid on
    grid minor
end

