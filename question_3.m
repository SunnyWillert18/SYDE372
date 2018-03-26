load('lab2_3.mat');
s = SequentialDiscriminant(a, b);

%TODO: EACH iteration will involve this process. put this in a function and
%call it conditionally based on confusion matrix entries (i.e. quasi-recursion) 

%get random prototypes
protos = s.randomSelect();
protA = [protos(1) protos(3)];
protB = [protos(2) protos(4)];

%find MED boundary
G = s.MED(protA, protB);

%generate confusion matrix entries 
%initialize known groups (A should be ones whereas B should be zeros)
known = [ones(200,1); zeros(200,1)];
%generate confusion matrix
c = confusionmat(known, double(G));

