load('lab2_3.mat');
s = SequentialDiscriminant(a, b);

while(numel(s.b) ~=0 || numel(s.a) ~= 0)
    c = s.iterateClassifier();
    result = s.checkConfusion(c);
    numel(s.b)
end
