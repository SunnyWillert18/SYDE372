load('lab2_3.mat');

s1 = SequentialDiscriminant(a, b);
s2 = SequentialDiscriminant(a, b);
s3 = SequentialDiscriminant(a, b);

%build classifiers
s1.buildClassifier();
s2.buildClassifier();
s3.buildClassifier();

%test classifiers
s1.plotClassifier(a,b, 'Sequential Classifier 1');
s2.plotClassifier(a,b, 'Sequential Classifier 2');
s3.plotClassifier(a,b, 'Sequential Classifier 3');