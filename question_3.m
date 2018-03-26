load('lab2_3.mat');
s = SequentialDiscriminant(a, b);
s1 = SequentialDiscriminant(a, b);
s2 = SequentialDiscriminant(a,b);

while(numel(s.b) ~=0 || numel(s.a) ~= 0)
    c = s.iterateClassifier();
    result = s.checkConfusion(c);
end

while(numel(s1.b) ~=0 || numel(s1.a) ~= 0)
    c = s1.iterateClassifier();
    result = s1.checkConfusion(c);
end

while(numel(s2.b) ~=0 || numel(s2.a) ~= 0)
    c = s2.iterateClassifier();
    result = s2.checkConfusion(c);
end


%testing
s.plotClassifier(a,b);
s1.plotClassifier(a,b);
s2.plotClassifier(a,b);