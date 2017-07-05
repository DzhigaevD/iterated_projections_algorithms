function out = P(currentPoint, destinationSet)
    distances = zeros(size(destinationSet,1),1);
    for ii = 1:size(destinationSet,1)
        distances(ii) = sqrt((currentPoint(1)-destinationSet(ii,1))^2+(currentPoint(2)-destinationSet(ii,2))^2);
    end
    indMin = find(distances == min(distances)); 
    
    out = [destinationSet(indMin(1),1),destinationSet(indMin(1),2)]; 
end

