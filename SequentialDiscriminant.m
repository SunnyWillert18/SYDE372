%A class that uses sequential discriminants to learn a classifier and
%classify points
classdef SequentialDiscriminant < handle 
    properties (Access = public)
        a;
        b;
        j;
        Gj;
        currentG;
        currentProtoA;
        currentProtoB;
        naBj;
        nbAj;
    end
    
    methods (Access = public)
        %sequential discriminant constructor
        function s = SequentialDiscriminant(a, b)
            s.a = a;
            s.b = b;
            s.j = 0;
            s.currentG = [];
            s.currentProtoA = [];
            s.currentProtoB = [];
            s.Gj = [];
            s.naBj = [];
            s.nbAj = [];
        end
        
        %selects a random prototype from a and from b using two independent
        %random numbers
        function result = randomSelect(s)
            if(numel(s.a) == 0)
                protA = [425 40];
            else
                aRand = randi([1 size(s.a,1)],1,1);
                protA = [s.a(aRand, 1) s.a(aRand, 2)];
            end
            if(numel(s.b) == 0)
                protB = [200 350];
            else
                bRand = randi([1 size(s.b,1)],1,1);
                protB = [s.b(bRand, 1) s.b(bRand, 2)];
            end
            s.currentProtoA = protA;
            s.currentProtoB = protB;
            result = [protA; protB];
        end
        
        %returns MED classifier for this iteration 
        function G = MED(s, protoA, protoB)
            %initialize test data grid
            if(numel(s.a) ~= 0 && numel(s.b ~= 0))
                X = [s.a(:,1); s.b(:,1)];
            elseif(numel(s.b) ~= 0)
                X = s.b(:,1);
            elseif(numel(s.a) ~= 0)
                X = s.a(:,1);
            end
            
            if(numel(s.a) ~=0 && numel(s.b) ~= 0)
                Y = [s.a(:,2); s.b(:,2)];
            elseif(numel(s.b ~=0))
                Y = s.b(:,2);
            elseif(numel(s.a) ~=0 )
                Y = s.a(:,2);
            end
            %calculate distances from each point to each prototype
            MED_A = sqrt((X - protoA(1)).^2 + (Y - protoA(2)).^2);
            MED_B = sqrt((X - protoB(1)).^2 + (Y - protoB(2)).^2);
            %classify
            G = MED_A < MED_B;
        end
        function confusion = iterateClassifier(s)
            %get random prototypes
            protos = s.randomSelect();
            protA = [protos(1) protos(3)];
            protB = [protos(2) protos(4)];

            %find MED boundary
            G = s.MED(protA, protB);
            s.currentG = G;

            %generate confusion matrix entries 
            %initialize known groups (A should be ones whereas B should be zeros)
            if(numel(s.a) ~= 0 && numel(s.b) ~= 0)
                known = [ones(size(s.a,1), 1); zeros(size(s.b,1),1)];
            elseif(numel(s.b ~= 0))
                known = zeros(size(s.b,1),1);
            elseif(numel(s.a) ~= 0)
                known = ones(size(s.a,1),1);
            end
            %generate confusion matrix
            confusion = confusionmat(known, double(G));
        end
        
        function result = checkConfusion(s, c)
            if(numel(c) == 1 )
                s.a = [];
                s.b = [];
                result = 1;
            else
                naB = c(2);
                nbA = c(3);
                if(naB == 0)
                    %save results
                    s.Gj = [s.Gj; [s.currentProtoA s.currentProtoB]];
                    s.naBj = [s.naBj; naB];
                    s.nbAj = [s.nbAj; nbA];
                    s.j = s.j + 1;
                    %delete points in b that classify as b
                    temp = [];
                    for i = (size(s.a, 1)+1):(size(s.a, 1)+size(s.b, 1))
                        if(s.currentG(i) == 1)
                            index = i - (size(s.a, 1));
                            temp = [temp; s.b(index, 1) s.b(index, 2)];
                        end
                    end
                    s.b = temp;
                    result = 1;
                elseif(nbA == 0)
                    %save results
                    s.Gj = [s.Gj; [s.currentProtoA s.currentProtoB]];
                    s.naBj = [s.naBj; naB];
                    s.nbAj = [s.nbAj; nbA];
                    s.j = s.j + 1;
                    %flag points in a that classify as a
                    temp = [];
                    for i = 1:size(s.a,1)
                        if(s.currentG(i) == 0)
                            temp = [temp; s.a(i, 1) s.a(i, 2)];
                        end
                    end
                    s.a = temp;
                    result = 1;
                else
                    result = 0;
                end
            end
        end
        
        function result = classify(s, point)
            j = 1;
            solved = 0;
            while(~solved)
                protoA = [s.Gj(j, 1), s.Gj(j, 2)];
                protoB = [s.Gj(j, 3), s.Gj(j, 4)];
                result = SequentialDiscriminant.classifyMED(protoA, protoB, point);
                if((result == 1 && s.nbAj(j) == 0) || (result == 0 && s.naBj(j) == 0))
                    solved = 1;
                else
                    j = j + 1;
                end
            end
        end
        
        function plotClassifier(s, a, b)
            %set range
            Xr = 50:1:550;
            Yr = 0:1:450;
            [X, Y] = meshgrid(Xr, Yr);
            classifications = X;
            for i = 1:numel(X)
                classifications(i)= s.classify([X(i), Y(i)]);
            end
            figure
            hold on
            scatter(a(:,1), a(:,2), 'r');
            scatter(b(:,1), b(:,2), 'c');
            contour(X, Y, classifications, 'k');
            title('Sequential Classifier Results');
            xlabel('x1');
            ylabel('x2');
            legend('Class a', 'Class b', 'Decision Boundary');
        end
    end
    
    methods (Static)
        function result = classifyMED(protoA, protoB, point)
            X = point(1);
            Y = point(2);
            MED_A = sqrt((X - protoA(1))^2 + (Y - protoA(2))^2);
            MED_B = sqrt((X - protoB(1))^2 + (Y - protoB(2))^2);
            result = MED_A < MED_B;
        end
    end
end