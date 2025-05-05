function [i, shifting_flag,dq_v_shifting] = AMT(i, igs, dq_v, map, shifting_flag, throtel,dq_v_shifting)
    if shifting_flag == 0
        possiple_dq_e_RPM = dq_v * igs * (30/pi); 
        possiple_T_e = arrayfun(@(rpm) search(map, rpm, throtel), possiple_dq_e_RPM);
        possiple_T_o = possiple_T_e .* igs;
        [max_T, idx] = max(possiple_T_o);
        torque_threshold = 1; 
        current_T = possiple_T_o(i);
        if (max_T > current_T + (torque_threshold)) && (idx > i)
            % Upshift
            i = min(i + 1, length(igs));
            shifting_flag = 1;
            dq_v_shifting=dq_v;
        elseif (max_T > current_T + (torque_threshold)) && (idx < i)
            % Downshift
            if abs(dq_v_shifting-dq_v)>21
                i = max(i - 1, 1);
                shifting_flag = 2;
                dq_v_shifting=dq_v;
            end
        end
    end
end