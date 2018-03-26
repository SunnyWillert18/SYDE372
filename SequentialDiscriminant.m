%A class that uses sequential discriminants to learn a classifier and
%classify points
classdef SequentialDiscriminant < handle 
    properties (Access = public)
        a;
        b;
        j;
        Gj;
    end
    
    methods (Access = public)
        %sequential discriminant constructor
        function s = SequentialDiscriminant(a, b)
            s.a = a;
            s.b = b;
            s.j = 0;
            s.Gj = [];
        end
        
        %selects a random prototype from a and from b using two independent
        %random numbers
        function result = randomSelect(s)
            aRand = randi([1 size(s.a,1)],1,1);
            bRand = randi([1 size(s.b,1)],1,1);
            protA = [s.a(aRand, 1) s.a(aRand, 2)];
            protB = [s.b(bRand, 1) s.b(bRand, 2)];
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
    end
    
    methods (Static)
    end
end