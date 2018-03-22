x = -10:0.1:10;

muA = 5;
sigmaA = 1;

%DATASET A
modelEstA = ModelEstimation(a);
%Get ML params for mu, sigma
gaussianA = modelEstA.parametricEstimationGaussian();
%Get ML params for lambda
expA = modelEstA.parametricEstimationExponential();
%set up pdfs for plotting
pdf1 = normpdf(x, muA, sigmaA);
pdf2 = normpdf(x, gaussianA(1), gaussianA(2));
pdf3 = exppdf(x, expA);
%gaussian assumption
ModelEstimation.comparePlots(x, pdf1, pdf2, 'Dataset A Gaussian Assumption')
%exponential assumption
ModelEstimation.comparePlots(x, pdf1, pdf3, 'Dataset A Exponential Assumption')

%DATASET B
lambdaB = 1;

modelEstB = ModelEstimation(b);
gaussianB = modelEstB.parametricEstimationGaussian();
expB = modelEstB.parametricEstimationExponential();
pdf1 = exppdf(x, lambdaB);
pdf2 = normpdf(x, gaussianB(1), gaussianB(2));
pdf3 = exppdf(x, expB);
ModelEstimation.comparePlots(x, pdf1, pdf2, 'Dataset B Gaussian Assumption');
ModelEstimation.comparePlots(x, pdf1, pdf3, 'Dataset B Exponential Assumption');