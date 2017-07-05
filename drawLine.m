function drawLine( currentPoint, nextPoint )
    ax = gca;
    line([currentPoint(1),nextPoint(1)],[currentPoint(2),nextPoint(2)],'Color','white','LineWidth',1);


end

