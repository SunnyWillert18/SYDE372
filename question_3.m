load('lab2_3.mat');
s1 = SequentialDiscriminant(a, b);
s2 = SequentialDiscriminant(a, b);
s3 = SequentialDiscriminant(a, b);
s4 = SequentialDiscriminant(a, b);
s5 = SequentialDiscriminant(a, b);
s6 = SequentialDiscriminant(a, b);
s7 = SequentialDiscriminant(a, b);
s8 = SequentialDiscriminant(a, b);
s9 = SequentialDiscriminant(a, b);
s10 = SequentialDiscriminant(a, b);
s11 = SequentialDiscriminant(a, b);
s12 = SequentialDiscriminant(a, b);
s13 = SequentialDiscriminant(a, b);
s14 = SequentialDiscriminant(a, b);
s15 = SequentialDiscriminant(a, b);
s16 = SequentialDiscriminant(a, b);
s17 = SequentialDiscriminant(a, b);
s18 = SequentialDiscriminant(a, b);
s19 = SequentialDiscriminant(a, b);
s20 = SequentialDiscriminant(a, b);

%build classifiers
s1.buildClassifier();
s2.buildClassifier();
s3.buildClassifier();
s4.buildClassifier();
s5.buildClassifier();
s6.buildClassifier();
s7.buildClassifier();
s8.buildClassifier();
s9.buildClassifier();
s10.buildClassifier();
s11.buildClassifier();
s12.buildClassifier();
s13.buildClassifier();
s14.buildClassifier();
s15.buildClassifier();
s16.buildClassifier();
s17.buildClassifier();
s18.buildClassifier();
s19.buildClassifier();
s20.buildClassifier();
%j1error = [s1.errorJ1,s2.errorJ1, s3.errorJ1

%test classifiers
s1.plotClassifier(a,b);
s2.plotClassifier(a,b);
s3.plotClassifier(a,b);
