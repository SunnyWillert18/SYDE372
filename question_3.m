load('lab2_3.mat');
s = SequentialDiscriminant(a, b);

while(s.j < 5)
    c = s.iterateClassifier();
    %order = 0;1
    result = s.checkConfusion(c);
end

