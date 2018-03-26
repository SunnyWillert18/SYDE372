load('lab2_3.mat');
s1 = SequentialDiscriminant(a, b);
s2 = SequentialDiscriminant(a, b);
s3 = SequentialDiscriminant(a,b);

%build classifiers
s1.buildClassifier();
s2.buildClassifier();
s3.buildClassifier();

%test classifiers
s1.plotClassifier(a,b);
s2.plotClassifier(a,b);
s3.plotClassifier(a,b);