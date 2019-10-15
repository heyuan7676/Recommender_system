function [overlap, contigency_table] = clustering_error(predicted_segmentation, true_segmentation)

i = 1;
for gp = unique(predicted_segmentation)'
    for kk = 1:size(true_segmentation,2)
        true_discovery_rate(i,kk) = devide(sum((predicted_segmentation == gp) .* (true_segmentation(:,kk) == 1)), sum(true_segmentation(:,kk) == 1));
        true_positive_rate(i,kk) = devide(sum((predicted_segmentation == gp) .* (true_segmentation(:,kk) == 1)),sum(predicted_segmentation == gp));
        overlap(i, kk) =  devide(sum((predicted_segmentation == gp) .* (true_segmentation(:,kk) == 1)),sum(predicted_segmentation == gp) + sum(true_segmentation(:,kk) == 1) - sum((predicted_segmentation == gp) .* (true_segmentation(:,kk) == 1)));
        
        contigency_table(gp,1) = sum((predicted_segmentation == gp) .* (true_segmentation(:,kk) == 1));
        contigency_table(gp,2) = sum((predicted_segmentation == gp) .* (true_segmentation(:,kk) == 0));
    end
    i = i+1;
end
