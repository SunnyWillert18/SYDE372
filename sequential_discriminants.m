data = load('lab2_3.mat');
j = 1;
G = [];
n = [];

discriminants = [];
while numel(data.a) ~= 0 && numel(data.b) ~= 0
    Gi, ni, data = getDiscriminants(data);
    G = [G,Gi];
    n = [n,ni];
    j = j+1;
end

% find a way to return both the discriminant and the altered dataset
function [Gi,ni, altered_data] = getDiscriminants(data)
    %labelled sets
    A = [];
    B = [];

    %get protoytpe
    a_rand = randi([1 numel(m.dataSet)],1,1);
    b_rand = randi([1 numel(m.dataSet)],1,1);
    za = [data.a(a_rand,1), data.a(a_rand,2)];
    zb = [data.b(b_rand,1), data.b(b_rand,2)];

    %get discriminant function
    g1 = @(x1,x2) -(za(1)*x1 + za(2)*x2) + (1/2)*(za'*za);
    g2 = @(x1,x2) -(zb(1)*x1 + zb(2)*x2) + (1/2)*(zb'*zb);
    G = g1 - g2;
    
    % label points and find confusion matrice entries
    naB = 0; %number of times G classifies point from a as class B
    nbA = 0; %number of times G classifies point from b as class A
    for i = 1:numel(a)
        a_euc_a = sqrt((a(i,1) - za(1)).^2 + (a(i,2) - za(1)).^2);
        a_euc_b = sqrt((a(i,1) - zb(1)).^2 + (a(i,2) - zb(1)).^2);

        % will only push the x value into the labelled array
        if a_euc_a < a_euc_b
            A = [A,a(i)];
        else
            B = [B,a(i)];
            naB = naB + 1;
        end
    end
    
    for i = 1:numel(b)
        b_euc_a = sqrt((b(i,1) - za(1)).^2 + (b(i,2) - za(1)).^2);
        b_euc_b = sqrt((b(i,1) - zb(1)).^2 + (b(i,2) - zb(1)).^2);

        % will only push the x value into the labelled array
        if b_euc_b < b_euc_a
            B = [B,b(i)];
        else
            A = [A,b(i)];
            nbA = nbA + 1;
        end
    end

    if naB == 0 
        % remove points -> remove points from b that G classifies as B
        for i = 1:numel(data.b)
            if any(B(:) == data.b(i))
                data.b(i,1) = [];
                data.b(i,2) = [];
            end
        end
        Gi = G;
        ni = [naB, nbA]; 
        altered_data = data;
    elseif nbA == 0
        % remove points -> remove points from a that G classifies as A
        for i = 1:numel(data.a)
            if any(A(:) == data.a(i))
                data.a(i,1) = [];
                data.a(i,2) = [];
            end
        end
        Gi = G;
        ni = [naB, nbA]; 
        altered_data = data;
    else
        % call recursive function
        Gi, ni, altered_data = getDiscriminants(data);
    end
end




