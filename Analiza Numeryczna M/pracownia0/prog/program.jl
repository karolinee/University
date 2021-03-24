using Plots

f(x) = x^2 - 4
x = range(-5, stop = 5, length = 100)
y = f.(x)
plot(x,y)
savefig("../doc/figura")
