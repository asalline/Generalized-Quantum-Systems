function [GGB_new, GGB_coefs, traces] = GGB_qudits(GGB, qudits)
GGB_new = cell(1, length(GGB)^2);
GGB_coefs = cell(1, length(GGB)^2);
traces = [];
n = 1;
for size = 1:qudits
    if size == 1
        GGB_new = GGB;
    else
        for j = 1:length(GGB_new)
            for k = 1:length(GGB)
                GGB_temp{n} = kron(GGB_new{j}, GGB{k});
%                 tracetest = trace(GGB_temp{n}*GGB_temp{n});
%                 trace_temp(n) = 1 / tracetest;
%                 GGB_temp2{n} = (1/tracetest) * GGB_temp{n};
                n = n+1;
            end
        end
        clear GGB_new
        GGB_new = GGB_temp;
%         GGB_coefs = GGB_temp2;
%         traces = [traces, trace_temp]
        clear GGB_temp 
%         clear GGB_temp2 trace_temp
        n = 1;
    end
end