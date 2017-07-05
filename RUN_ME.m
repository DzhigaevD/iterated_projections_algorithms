% Draw two constrain sets with a free hand tool and put a starting point
% anywhere within the field
% NOTATION:
% currentPount - coordinates of a current guess of the solution
% Template for the projection step: nextPoint = P(currentPoint,sets{k}), k=[1,2] - 2 sets for now
while 1
    close all;
    clear;
    
    %%%%%% SELECT ALGORITHM HERE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    algorithm = 'DM';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    size_field = 10000;
    work_field = zeros(size_field);

    figure;
    imagesc(work_field);axis image;colormap jet

    h1 = imfreehand('Closed',0);

    % [horiz, vertic]
    a = getPosition(h1);
    setColor(h1,'red');

    h2 = imfreehand('Closed',0);

    b = getPosition(h2);
    setColor(h2,'blue');

    h3 = impoint;

    currentPoint = getPosition(h3);
    setColor(h3,'white');
    
    sets = {a,b};
    time = getTimeStamp();
%     save(sprintf('Sets/Set_%s.mat',time),'sets');  

    for ii = 1:100
        if min(currentPoint(:))<0 || max(currentPoint(:))>size_field
            disp('Algorithm is not converging! Try another starting point.');
            break;
        else
            switch algorithm
                case 'MY'
                    %     TRIALS                    
                    nextPoint = currentPoint+P(P(currentPoint,sets{1}),sets{2})-2*P(P(currentPoint,sets{2}),sets{1});                    
                case 'ER'                                        
                    nextPoint = P(P(currentPoint,sets{1}),sets{2});
                case 'SF'                                        
                    nextPoint = 2*P(P(currentPoint,sets{2}),sets{1})-P(currentPoint,sets{2});
                case 'HIO'                        
                    nextPoint = currentPoint+P(2*P(currentPoint,sets{2})-currentPoint,sets{1})-P(currentPoint,sets{2}); 
                case 'DM'                    
                    beta = 0.8;
                    nextPoint = currentPoint+beta*(P(P(currentPoint,sets{2})+(1/beta)*(P(currentPoint,sets{2})-currentPoint),sets{1})-P(P(currentPoint,sets{1})-(1/beta)*(P(currentPoint,sets{1})-currentPoint),sets{2}));                    
            end
            
            drawLine(currentPoint,nextPoint);
            currentPoint = nextPoint;
        end
        %     disp(E);
%         pause(0.01);
%         waitforbuttonpress
    end
    disp('Pres anykey to restart...')
    waitforbuttonpress    
end