dataA = al;
dataB = bl;
dataC = cl;

muA = getMean(dataA);
sigmaA = getSigma(dataA, muA);

muB = getMean(dataB);
sigmaB = getSigma(dataB, muB);

muC = getMean(dataC);
sigmaC = getSigma(dataC, muC);

minX = min([min(dataA(:,1)) min(dataB(:,1)) min(dataC(:,1))]);
maxX = max([max(dataA(:,1)) max(dataB(:,1)) max(dataC(:,1))]);
minY = min([min(dataA(:,2)) min(dataB(:,2)) min(dataC(:,2))]);
maxY = max([max(dataA(:,2)) max(dataB(:,2)) max(dataC(:,2))]);


%Parametric Classification
[testPointXNonPar, testPointYNonPar] = meshgrid(minX:1:maxX, minY:1:maxY);
classificationNonPar = testPointXNonPar;
for i = 1:size(testPointXNonPar, 1)
   for j = 1:size(testPointXNonPar, 2)
        currentPoint = [testPointXNonPar(i,j); testPointYNonPar(i,j)];
        classificationNonPar(i,j) = MLClassifier(muA, sigmaA, muB, sigmaB, muC, sigmaC, currentPoint);  
   end
end

%Non-parametric Classification 
res = [1 minX  minY maxX maxY];

mu = [200 200];
sigma = [400 0; 0 400];

[x,y] = meshgrid(1:1:400);
win = mvnpdf([x(:) y(:)], mu, sigma);
win = reshape(win, 400, 400);

[pA, xA, yA] = parzen(dataA, res, win);
[pB, xB, yB] = parzen(dataB, res, win);
[pC, xC, yC] = parzen(dataC, res, win);

[testPointXPar, testPointYPar] = meshgrid(xA, yA);
classificationPar = testPointXPar;

for i = 1:size(testPointXPar, 1)
       for j = 1:size(testPointXPar, 2)            
            if(pA(i,j) > pB(i,j) && pA(i,j) > pC(i,j))
                classificationPar(i,j) = 1; 
            elseif (pB(i,j) > pA(i,j) && pB(i,j) > pC(i,j))
                classificationPar(i,j) = 2;
            else
                classificationPar(i,j) = 3;
            end
       end
end

hold on;
set(gcf,'color','w');
title('Classification Boundary Generated With Parametric Estimation vs. Non-Parametric Estimation', 'FontSize', 13);
xlabel('x1', 'FontSize', 14);
ylabel('x2', 'FontSize', 14);
scatter(dataA(:,1), dataA(:, 2));
scatter(dataB(:,1), dataB(:, 2));
scatter(dataC(:,1), dataC(:, 2));
contour(testPointXNonPar, testPointYNonPar, classificationNonPar, 'k');
contour(testPointXPar, testPointYPar, classificationPar, 'b');
legend('Class al', 'Class bl' , 'Class cl', 'Parametric Estimation Decision Boundary', 'Non Parametric Estimation Decision Boundary', 'Location', 'SouthOutside');
hold off;

    
function mu = getMean(dataSet)
     xData = dataSet(:,1);
     yData = dataSet(:,2);
            
     muX = sum(xData) / numel(xData);
     muY = sum(yData) / numel(yData);
     
     mu = [muX; muY];
end

function sigma = getSigma(dataSet, mu)
     xData = dataSet(:,1);
     yData = dataSet(:,2);
     
     sigma = cov(dataSet);
end


function identifiedClass = MLClassifier(mu1, sigma1, mu2, sigma2, mu3, sigma3, currentPoint)
     distance1 = getGeneralizedEuclideanDistance(mu1, sigma1, currentPoint);
     distance2 = getGeneralizedEuclideanDistance(mu2, sigma2, currentPoint);
     distance3 = getGeneralizedEuclideanDistance(mu3, sigma3, currentPoint);     
     
     if(((distance2 - distance1) > (log(det(sigma1)/det(sigma2)))) && ((distance3 - distance1) > (log(det(sigma1)/det(sigma3)))))
       identifiedClass = 1;
     elseif(((distance1 - distance3) > (log(det(sigma3)/det(sigma1)))) && ((distance2 - distance3) > (log(det(sigma3)/det(sigma2)))))
       identifiedClass = 3;
     else
       identifiedClass = 2;
     end   
end

function distance = getGeneralizedEuclideanDistance(mu, covarience, point)
    distance = transpose(point - mu) * inv(covarience) * (point - mu);
end  
