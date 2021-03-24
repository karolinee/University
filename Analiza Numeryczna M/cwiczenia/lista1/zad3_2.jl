
using Printf

function error(x)
    x_poprawny = -14.636489
    res::Float64 = abs(x-x_poprawny)/abs(x)
    return res
end


value = 4.71
w(x) = x^3 - 6x^2 + 3x - 0.149
w_2(x) = ((x-6)x+3)x - 0.149

x1 = w(Float16(value))
x2 = w(Float32(value))
x3 = w(Float64(value))

@printf("wartość w arytmetyce Float 16: %f\t%.64f\n", x1, error(x1))
@printf("wartość w arytmetyce Float 32: %f\t%.64f\n", x2, error(x2))
@printf("wartość w arytmetyce Float 64: %f\t%.64f\n", x3, error(x3))

x1 = w_2(Float16(value))
x2 = w_2(Float32(value))
x3 = w_2(Float64(value))
println()
@printf("wartość w arytmetyce Float 16: %f\t%.64f\n", x1, error(x1))
@printf("wartość w arytmetyce Float 32: %f\t%.64f\n", x2, error(x2))
@printf("wartość w arytmetyce Float 64: %f\t%.64f\n", x3, error(x3))
