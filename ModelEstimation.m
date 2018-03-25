%A class to calculate 1-dimensional parametric and non parametric estimates of
%distributions from sets of datapoints. 
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
        
        %A function to calculate the ML estimation of the params of an
        %assumed exponential distribution.
        %Outputs: lambda
        function result = parametricEstimationExponential(m)
            %ML estimate of lambda as derived in tutorial
            result = numel(m.dataSet) / sum(m.dataSet);
        end
        
        %A function to calculate the ML estimation of the params of an
        %assumed uniform distribution.
        %Outputs: [a, b]
        function result = parametricEstimationUniform(m)
            %ML estimate of a and b are min and max x axis values,
            %respectively
            result = [min(m.dataSet), max(m.dataSet)];
        end
        
        %A function to calculate the Parzen Window estimation of a
        %distribution.
        %Outputs: Vector of evaluated points of estimate
        function result = nonParametricEstimationParzen(m, sigma, k)
            %calculate h param
            h = k / sqrt(numel(m.dataSet));
            %define window function
            w = @(x) (1/(sqrt(2*pi)*sigma)) * exp(-1/2*(x/sigma)^2);
            out = [];
            %compute probability according to parzen window sum for each point
            for i = -10:0.1:10
                sum = 0;
                for j = 1:numel(m.dataSet)
                    sum = sum + (1/h * w((i-m.dataSet(j))/h));
                end
                out = [out 1/(numel(m.dataSet))*sum];
            end
            result = out;
        end
    end
    
    methods (Static)
        %A function to plot two distributions on the same plot.
        function comparePlots(x, pdf1, pdf2, graphTitle)
            figure
            hold on 
            title(graphTitle);
            %true pdf
            plot(x, pdf1, 'b');
            %estimated pdf
            plot(x, pdf2, 'r');
            legend('True PDF', 'Estimated PDF');
            xlabel('x');
            ylabel('p(x)');
        end
    end
end