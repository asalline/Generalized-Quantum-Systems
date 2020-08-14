function GGB_new = GGB_qudits(GGB, qudits)
GGB_new = cell(1, length(GGB)^2);
n = 1;
for size = 1:qudits
    if size == 1
        GGB_new = GGB;
    else
        for j = 1:length(GGB_new)
            for k = 1:length(GGB)
                GGB_temp{n} = kron(GGB_new{j}, GGB{k});
                n = n+1;
            end
        end
        clear GGB_new
        GGB_new = GGB_temp;
        clear GGB_temp
        n = 1;
    end
end