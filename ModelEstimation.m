classdef ModelEstimation < handle
    properties (Access = public)
        dataSet;
    end
    methods (Access = public)
        function m = ModelEstimation(dataSet)
            m.dataSet = dataSet;
        end
        
        %A function to calculate the ML estimation of the params of an
        %assumed Gaussian distribution.
        %Outputs: [mu, sigma]
        function result = parametricEstimationGaussian(m)
            %ML estimate of mean is sample mean
            mu = sum(m.dataSet) / numel(m.dataSet);
            %ML estimate of variance is sample variance
            sigma = sum((m.dataSet - mu).^2) / numel(m.dataSet);
            result = [mu, sigma];
        end
        
        function result = parametricEstimationExponential(m)
            %ML estimate of lambda as derived in tutorial
            result = numel(m.dataSet) / sum(m.dataSet);
        end
    end
    
    methods (Static)
        function comparePlots(x, pdf1, pdf2, graphTitle)
            figure
            hold on 
            title(graphTitle);
            plot(x, pdf1, 'b');
            plot(x, pdf2, 'r');
        end
    end
end