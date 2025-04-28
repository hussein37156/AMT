function [i, shifting_flag] = AMT(i, igs, dq_v, map, shifting_flag, throtel)
    if shifting_flag == 0
        possiple_dq_e_RPM = dq_v * igs * (30/pi); 
        possiple_T_e = arrayfun(@(rpm) search(map, rpm, throtel), possiple_dq_e_RPM);
        possiple_T_o = possiple_T_e .* igs;

        % Find gear with maximum output torque
        [max_T, idx] = max(possiple_T_o);
        
        % Only shift if there's a significant torque advantage (optional)
        torque_threshold = 5; 
        current_T = possiple_T_o(i);
        
        if (max_T > current_T + torque_threshold) && (idx > i)
            % Upshift
            i = min(i + 1, length(igs));
            shifting_flag = 1;
        elseif (max_T > current_T + torque_threshold) && (idx < i)
            % Downshift
            i = max(i - 1, 1);
            shifting_flag = 2;
        end
    end
end