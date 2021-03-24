
using Printf
function w1_16()
    x::Float16 = 4.71
    res::Float16 = x^3 - 6x^2 + 3x - 0.149
    return res
end


function w1_32()
    x::Float32 = 4.71
    res::Float32 = x^3 - 6x^2 + 3x - 0.149
    return res
end


function w1_64()
    x::Float64 = 4.71
    res::Float64 = x^3 - 6x^2 + 3x - 0.149
    return res
end


function w2_16()
    x::Float16 = 4.71
    res::Float16 = ((x-6)x+3)x - 0.149
    return res
end


function w2_32()
    x::Float32 = 4.71
    res::Float32 = ((x-6)x+3)x - 0.149
    return res
end


function w2_64()
    x::Float64 = 4.71
    res::Float64 = ((x-6)x+3)x - 0.149
    return res
end


function error(x)
    x_poprawny = -14.636489
    res::Float64 = abs(x-x_poprawny)/abs(x)
    return res
end


x1 = w1_16()
x2 = w1_32()
x3 = w1_64()
@printf("wartość w arytmetyce Float 16: %f\t%.64f\n", x1, error(x1))
@printf("wartość w arytmetyce Float 32: %f\t%.64f\n", x2, error(x2))
@printf("wartość w arytmetyce Float 64: %f\t%.64f\n", x3, error(x3))


x4 = w2_16()
x5 = w2_32()
x6 = w2_64()
println()
@printf("wartość w arytmetyce Float 16: %f\t%.64f\n", x4, error(x4))
@printf("wartość w arytmetyce Float 32: %f\t%.64f\n", x5, error(x5))
@printf("wartość w arytmetyce Float 64: %f\t%.64f\n", x6, error(x6))


# wartość w arytmetyce Float 16: -14.578125       0.0040035326902464613008092442214547190815210342407226562500000000
# wartość w arytmetyce Float 32: -14.636500       0.0000007760449059200675272693608491847427899301692377775907516479
# wartość w arytmetyce Float 64: -14.636489       0.0000000000000004854598228851877995184304307788459326810081304396
#
# wartość w arytmetyce Float 16: -14.632813       0.0002512504004270672179968681980710698553593829274177551269531250
# wartość w arytmetyce Float 32: -14.636490       0.0000000593150455557003952964963795161518200771411102323327213526
# wartość w arytmetyce Float 64: -14.636489       0.0000000000000000000000000000000000000000000000000000000000000000
