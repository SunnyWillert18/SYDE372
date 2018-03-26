load('lab2_1.mat');
x = -10:0.1:10;

%DATASET A
muA = 5;
sigmaA = 1;

modelEstA = ModelEstimation(a);
%Get ML params for mu, sigma
gaussianA = modelEstA.parametricEstimationGaussian();
%Get ML params for lambda
expA = modelEstA.parametricEstimationExponential();
%Get ML params for uniform
uniA = modelEstA.parametricEstimationUniform();
%Get Parzen window function sigma=0.1
parzenA = modelEstA.nonParametricEstimationParzen(0.1, 50);
%Get Parzen window function sigma=0.4
parzenA2 = modelEstA.nonParametricEstimationParzen(0.4, 12);
%set up pdfs for plotting
pdf1 = normpdf(x, muA, sigmaA);
pdf2 = normpdf(x, gaussianA(1), gaussianA(2));
pdf3 = exppdf(x, expA);
pdf4 = unifpdf(x, uniA(1), uniA(2));
%gaussian assumption
ModelEstimation.comparePlots(x, pdf1, pdf2, 'Dataset A Gaussian Assumption')
%exponential assumption
ModelEstimation.comparePlots(x, pdf1, pdf3, 'Dataset A Exponential Assumption')
%uniform assumption
ModelEstimation.comparePlots(x, pdf1, pdf4, 'Dataset A Uniform Assumption')
%parzen window sigma = 0.1
ModelEstimation.comparePlots(x, pdf1, parzenA, 'Dataset A Parzen Window Sigma = 0.1');
%parzen window sigma = 0.4
ModelEstimation.comparePlots(x, pdf1, parzenA2, 'Dataset A Parzen Window Sigma = 0.4');

%DATASET B
lambdaB = 1;

modelEstB = ModelEstimation(b);
gaussianB = modelEstB.parametricEstimationGaussian();
expB = modelEstB.parametricEstimationExponential();
uniB = modelEstB.parametricEstimationUniform();
parzenB = modelEstB.nonParametricEstimationParzen(0.1, 50);
parzenB2 = modelEstB.nonParametricEstimationParzen(0.4, 10);
pdf1 = exppdf(x, lambdaB);
pdf2 = normpdf(x, gaussianB(1), gaussianB(2));
pdf3 = exppdf(x, expB);
pdf4 = unifpdf(x, uniB(1), uniB(2));
ModelEstimation.comparePlots(x, pdf1, pdf2, 'Dataset B Gaussian Assumption')
ModelEstimation.comparePlots(x, pdf1, pdf3, 'Dataset B Exponential Assumption')
ModelEstimation.comparePlots(x, pdf1, pdf4, 'Dataset B Uniform Assumption')
ModelEstimation.comparePlots(x, pdf1, parzenB, 'Dataset B Parzen Window Sigma = 0.1');
ModelEstimation.comparePlots(x, pdf1, parzenB2, 'Dataset B Parzen Window Sigma = 0.4');