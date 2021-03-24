
using Plots
using Polynomials
using Printf
pyplot()

coef = [5, -6, -8, 4, 8]
f = Poly(coef)

xs = LinRange(-1,1, 1000);
ys = map(f, xs)
plot(xs, ys)
savefig("../doc/poczatkowy")
close()

random_points = rand(100)
random_points = sort(map(x -> 2x - 1,random_points))
random_points_values = f.(random_points)
random_points_values_added = map(x -> x + (1/5)*rand() - 1/10,random_points_values) 
scatter(random_points,random_points_values_added)
savefig("../doc/zaburzone")
close()

function scalar(values_f,values_g)
    result = 0
    for i = 1:100
        result += (values_f[i] * values_g[i])
    end
    return result
end

function cal_c(p1)
    xp1 = Float64[]
    for i = 1:100
        push!(xp1,random_points[i]*p1[i])
    end
    return scalar(xp1, p1)/scalar(p1, p1)
end

function cal_d(p1, p2)
    return scalar(p1, p1)/scalar(p2, p2)
end

function calculate_base(n)
    coef = Float64[]
    c = Float64[]
    d = Float64[]

    if n >= 0
        push!(c,0)
        push!(d,0)
        P0 = ones(100)
        push!(coef,scalar(random_points_values_added,P0)/scalar(P0,P0))
    end
    
    if n >= 1
        push!(c,cal_c(P0))
        push!(d,0)
        P1 = Float64[]
        for i = 1:100
            push!(P1,random_points[i] - c[2])
        end
        push!(coef, scalar(random_points_values_added,P1)/scalar(P1,P1))
    end
    if n>=2
        for i = 3:n+1
            push!(c,cal_c(P1))
            push!(d,cal_d(P1, P0))
            P2 = Float64[]
            for j = 1:100
                push!(P2,((random_points[j] - c[i]) * P1[j] - d[i] * P0[j]))
            end
            push!(coef, scalar(random_points_values_added,P2)/scalar(P2,P2))
            P0 = P1
            P1 = P2
        end
    end
    return coef, c, d      
end  

function Clenshaw(n,coef, β, γ,x)
    v2 = coef[n+1]
    if n >= 1
        v3 = v2
        v2 = coef[n] + (x - β[n+1])*v3
    end
    if n >= 2
        for i = n-1:-1:1
            v1 = coef[i] + (x - β[i + 1]) * v2 - γ[i + 2] * v3
            v3 = v2
            v2 = v1
        end
    end
    return v2
end

coef, β, γ = calculate_base(1)
ys1 = map(x -> Clenshaw(1, coef, β, γ,x), xs)
plot(xs, ys1)
savefig("../doc/opt1")
close()

coef, β, γ = calculate_base(2)
ys2 = map(x -> Clenshaw(2, coef, β, γ,x), xs)
plot(xs, ys2)
savefig("../doc/opt2")
close()

coef, β, γ = calculate_base(3)
ys3 = map(x -> Clenshaw(3, coef, β, γ,x), xs)
plot(xs, ys3)
savefig("../doc/opt3")
close()

coef, β, γ = calculate_base(4)
ys4 = map(x -> Clenshaw(4, coef, β, γ,x), xs)
plot(xs, ys4)
savefig("../doc/opt4")
close()

coef, β, γ = calculate_base(5)
ys5 = map(x -> Clenshaw(5, coef, β, γ,x), xs)
plot(xs, ys5)
savefig("../doc/opt5")
close()

coef, β, γ = calculate_base(6)
ys6 = map(x -> Clenshaw(6, coef, β, γ,x), xs)
plot(xs, ys6)
savefig("../doc/opt6")
close()

coef, β, γ = calculate_base(30)
ys30 = map(x -> Clenshaw(30, coef, β, γ,x), xs)
plot(xs, ys30)
savefig("../doc/opt30")
close()

coef, β, γ = calculate_base(99)
ys99 = map(x -> Clenshaw(99, coef, β, γ,x), xs)
plot(xs, ys99)
savefig("../doc/opt99")
close()

function max_error(x,x1)
    error = Float64[]
    for i = 1:100
        push!(error, abs(x[i] - x1[i]))
    end
    return maximum(error)
end

function optimal(n,y)
    error = Float64[]
    for i = 1:n
        coef, β, γ = calculate_base(i)
        ys_optimal = map(x -> Clenshaw(i, coef, β, γ,x), random_points)
        push!(error,max_error(y,ys_optimal))
    end
    return error
end

optimal_normal = optimal(99,random_points_values)
optimal_added = optimal(99,random_points_values_added)

for i = 1:99
    @printf("%i & %0.8f & %0.8f \\\\\n", i, optimal_normal[i], optimal_added[i])
end

