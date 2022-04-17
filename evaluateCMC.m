function [ ranks, retrievalRate ] = evaluateCMC( results )
%EVALUATECMC Summary of this function goes here
%   Detailed explanation goes here
        
        % eye(x,y) may be used here
        [x, y] = size(results);
        true_IDs = zeros(x,y);
        for i=1:x
            for j=1:y
                if i == j
                    true_IDs(i,j) = 1;
                end
            end
        end
        
        %generate CMC
        max_rank = y;
        
        %possible ranks
        ranks = 1:max_rank;
        
        %sort the rows
%         results = zeros(x,y);
        true_IDs_sort = zeros(x,y);
        for i=1:x
            [results(i,:), ind] = sort(results(i,:));
            true_IDs_sort(i,:) =  true_IDs(i,ind);
        end
        
        %iterate through ranks
        retrievalRate = zeros(1,max_rank);
        tmp = 0;
        for i=1:max_rank
            tmp = tmp + sum(true_IDs_sort(:,i));
            retrievalRate(1,i) = (tmp/x)*100;
        end  
end

