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

j1error = [s1.errorJ1 s2.errorJ1 s3.errorJ1 s4.errorJ1 s5.errorJ1 s6.errorJ1 s7.errorJ1 s8.errorJ1 s9.errorJ1 s10.errorJ1 s11.errorJ1 s12.errorJ1 s13.errorJ1 s14.errorJ1 s15.errorJ1 s16.errorJ1 s17.errorJ1 s18.errorJ1 s19.errorJ1 s20.errorJ1];
j2error = [s1.errorJ2 s2.errorJ2 s3.errorJ2 s4.errorJ2 s5.errorJ2 s6.errorJ2 s7.errorJ2 s8.errorJ2 s9.errorJ2 s10.errorJ2 s11.errorJ2 s12.errorJ2 s13.errorJ2 s14.errorJ2 s15.errorJ2 s16.errorJ2 s17.errorJ2 s18.errorJ2 s19.errorJ2 s20.errorJ2];
j3error = [s1.errorJ3 s2.errorJ3 s3.errorJ3 s4.errorJ3 s5.errorJ3 s6.errorJ3 s7.errorJ3 s8.errorJ3 s9.errorJ3 s10.errorJ3 s11.errorJ3 s12.errorJ3 s13.errorJ3 s14.errorJ3 s15.errorJ3 s16.errorJ3 s17.errorJ3 s18.errorJ3 s19.errorJ3 s20.errorJ3];
j4error = [s1.errorJ4 s2.errorJ4 s3.errorJ4 s4.errorJ4 s5.errorJ4 s6.errorJ4 s7.errorJ4 s8.errorJ4 s9.errorJ4 s10.errorJ4 s11.errorJ4 s12.errorJ4 s13.errorJ4 s14.errorJ4 s15.errorJ4 s16.errorJ4 s17.errorJ4 s18.errorJ4 s19.errorJ4 s20.errorJ4];
j5error = [s1.errorJ5 s2.errorJ5 s3.errorJ5 s4.errorJ5 s5.errorJ5 s6.errorJ5 s7.errorJ5 s8.errorJ5 s9.errorJ5 s10.errorJ5 s11.errorJ5 s12.errorJ5 s13.errorJ5 s14.errorJ5 s15.errorJ5 s16.errorJ5 s17.errorJ5 s18.errorJ5 s19.errorJ5 s20.errorJ5];

js = [1 2 3 4 5];
error_avgs = [sum(j1error)/20 sum(j2error)/20 sum(j3error)/20 sum(j4error)/20 sum(j5error)/20];
error_mins = [min(j1error) min(j2error) min(j3error) min(j4error) min(j5error)];
error_maxs = [max(j1error) max(j2error) max(j3error) max(j4error) max(j5error)];
error_stds = [std(j1error) std(j2error) std(j3error) std(j4error) std(j5error)];

figure
hold on
plot(js, error_avgs, 'r');
plot(js, error_mins, 'b');
plot(js, error_maxs, 'm');
plot(js, error_stds, 'c');
title('Sequential Classifier Error Rate Results');
xlabel('J');
ylabel('Error rate');
legend('Average error rate', 'Minimum error rate', 'Maximum error rate', 'Error rate standard deviation');