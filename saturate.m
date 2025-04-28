function y = saturate(x, min_val, max_val)
    y = min(max(x, min_val), max_val);
end
