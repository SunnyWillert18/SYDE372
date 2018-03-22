x = -10:0.1:10;

muA = 5;
sigmaA = 1;

%GAUSSIAN ESTIMATION
modelEstA = ModelEstimation(a, muA, sigmaA);
%Get ML params for mu, sigma
resultA = modelEstA.parametricEstimationGaussian();
%set up pdfs for plotting
pdf1 = normpdf(x, muA, sigmaA);
pdf2 = normpdf(x, resultA(1), resultA(2));
ModelEstimation.comparePlots(x, pdf1, pdf2)

lambdaB = 1;

modelEstB = ModelEstimation(b);
resultB = modelEstB.parametricEstimationGaussian();
pdf1 = exppdf(x, lambdaB);
pdf2 = normpdf(x, resultB(1), resultB(2));
ModelEstimation.comparePlots(x, pdf1, pdf2);