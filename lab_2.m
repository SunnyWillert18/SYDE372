x = -10:0.1:10;

muA = 5;
sigmaA = 1;

%DATASET A
modelEstA = ModelEstimation(a);
%Get ML params for mu, sigma
gaussianA = modelEstA.parametricEstimationGaussian();
%Get ML params for lambda
expA = modelEstA.parametricEstimationExponential();
%Get ML params for uniform
uniA = modelEstA.parametricEstimationUniform();
%set up pdfs for plotting
pdf1 = normpdf(x, muA, sigmaA);
pdf2 = normpdf(x, gaussianA(1), gaussianA(2));
pdf3 = exppdf(x, expA);
pdf4 = unifpdf(x, uniA(1), uniA(2));
%plot rectangle 
%gaussian assumption
ModelEstimation.comparePlots(x, pdf1, pdf2, 'Dataset A Gaussian Assumption')
%exponential assumption
ModelEstimation.comparePlots(x, pdf1, pdf3, 'Dataset A Exponential Assumption')
%uniform assumption
ModelEstimation.comparePlots(x, pdf1, pdf4, 'Dataset A Uniform Assumption')

%DATASET B
lambdaB = 1;

modelEstB = ModelEstimation(b);
gaussianB = modelEstB.parametricEstimationGaussian();
expB = modelEstB.parametricEstimationExponential();
uniB = modelEstB.parametricEstimationUniform();
pdf1 = exppdf(x, lambdaB);
pdf2 = normpdf(x, gaussianB(1), gaussianB(2));
pdf3 = exppdf(x, expB);
pdf4 = unifpdf(x, uniB(1), uniB(2));
ModelEstimation.comparePlots(x, pdf1, pdf2, 'Dataset B Gaussian Assumption')
ModelEstimation.comparePlots(x, pdf1, pdf3, 'Dataset B Exponential Assumption')
ModelEstimation.comparePlots(x, pdf1, pdf4, 'Dataset B Uniform Assumption')