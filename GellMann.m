function GMM_cell = GellMann(dimension)

% dimension = 3;
n = 1;
GMM_cell = cell(1, dimension^2 - 1);

%Symmetric GGM's
for k = 1:dimension
    ket = zeros(1,dimension)';
    ket(k) = 1;
    for j = 1:k-1
        bra = zeros(1,dimension);
        bra(j) = 1;
        GMM_cell{n} = kron(ket,bra) + kron(bra',ket');
        n = n + 1;
    end
end

%Antisymmetric GGM's
for k = 1:dimension
    j_ket = zeros(1,dimension);
    j_ket(k) = 1;
    for j = 1:k-1
        k_bra = zeros(1,dimension)';
        k_bra(j) = 1;
        GMM_cell{n} = -1i * kron(j_ket,k_bra) + 1i * kron(k_bra',j_ket');
        n = n + 1;
    end
end

% Diagonal GGM's
for l = 1:dimension-1
    l_ket = zeros(1,dimension)';
    l_ket(l+1) = 1;
    alpha = sqrt(2 / (l * (l + 1)));
    GMM = zeros(dimension,dimension);
    for j = 1:l
        j_ket = zeros(1,dimension);
        j_ket(j) = 1;
        GMM = GMM + kron(j_ket,j_ket');
    end
    GMM_cell{n} = alpha * (GMM - l * kron(l_ket, l_ket'));
    n = n+1;
end
end