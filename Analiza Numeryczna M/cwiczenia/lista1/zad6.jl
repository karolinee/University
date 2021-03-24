function convert_to_fraction(str::String)::Float64
    x::Float64 = 0.5
    res::Float64 = 0
    for i = 1:52
        res += '1' == str[i] ? x : 0
        x /= 2
    end
    return res
end

function bits_to_float64(str::String)::Float64
    sign = str[1] == '1' ? -1 : 1
    exp = parse(Int,str[2:12],base=2) - 1023
    return sign * (1.0 + convert_to_fraction(str[13:end])) * 2.0^exp
end

println(bits_to_float64(bitstring(6.78)))
