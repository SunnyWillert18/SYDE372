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
            aRand = randi([1 size(s.a,1)],1,1);
            bRand = randi([1 size(s.b,1)],1,1);
            protA = [s.a(aRand, 1) s.a(aRand, 2)];
            protB = [s.b(bRand, 1) s.b(bRand, 2)];
            s.currentProtoA = protA;
            s.currentProtoB = protB;
            result = [protA; protB];
        end
        
        %returns MED classifier for this iteration 
        function G = MED(s, protoA, protoB)
            %initialize test data grid
            X = [s.a(:,1); s.b(:,1)];
            Y = [s.a(:,2); s.b(:,2)];
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
            known = [ones(200,1); zeros(200,1)];
            %generate confusion matrix
            confusion = confusionmat(known, double(G));
        end
        
        function result = checkConfusion(s, c)
            naB = c(3);
            nbA = c(2);
            if(naB == 0)
                %save results
                s.Gj = [s.Gj; [s.currentProtoA s.currentProtoB]];
                s.naBj = [s.naBj; naB];
                s.nbAj = [s.nbAj; nbA];
                s.j = s.j + 1;
                %delete points in b that classify as b
                for i = size(s.a, 1)+1:size(s.a, 1)+size(s.b, 1)
                    if(s.currentG(i) == 0)
                        s.b(i - (size(s.a, 1)+1), :) = [];
                    end
                end
                result = 1;
            elseif(nbA == 0)
                %save results
                s.Gj = [s.Gj; [s.currentProtoA s.currentProtoB]];
                s.naBj = [s.naBj; naB];
                s.nbAj = [s.nbAj; nbA];
                s.j = s.j + 1;
                %delete points in a that classify as a
                for i = 1:size(s.a,1)
                    if(s.currentG(i) == 1)
                        i
                        s.a(i, :) = [];
                    end
                end
                result = 1;
            else
                result = 0;
            end
        end
    end
    
    methods (Static)
    end
end