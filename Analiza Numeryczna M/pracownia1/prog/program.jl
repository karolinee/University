#Analiza Numeryczna(M) - Pracownia 1 - Zadanie P1.2
#Karolina Jeziorska

using PyPlot

#funkcje do obliczania błędu
function absolute_error(exact_res, res)
    return abs(exact_res - res)
end

function relative_error(exact_res, res)
    return absolute_error(exact_res, res)/abs(exact_res)
end

function exact_number(exact_res, res)
    return -log(10,relative_error(exact_res, res))
end



function normal_sum(b, e, f,typ::Type)
    step = b < e ? 1 : -1
    s::typ = 0
    for i = b:step:e
        s += typ(f(typ(i)))
    end
    return s
end

function Kahan_sum(b, e, f, typ::Type)
    s::typ = f(b)
    c::typ = 0
    for i = (b+1):e
        y::typ = c + typ(f(typ(i)))
        t::typ = s + y
        c = (s - t) + y
        s = t
    end
    return s
end

g1(k) = k^(-2) 
g2(k) = (-1)*(k^(-2)) + 1
g3(k) = ((-1)^k)*(k^(-2))
g4(k) = (-1)*(k^(-2))

setprecision(128)


results = ["wynik dokładny", 
    "norm32", 
    "norm64", 
    "odwróc32", 
    "odwróc64", 
    "Kahan32", 
    "Kahan64"]
results_g1 = Number[]
results_g2 = Number[]
results_g3 = Number[]
results_g4 = Number[]

push!(results_g1, Kahan_sum(1,10000,g1,BigFloat))
push!(results_g2, Kahan_sum(1,10000,g2,BigFloat))
push!(results_g3, Kahan_sum(1,10000,g3,BigFloat))
push!(results_g4, Kahan_sum(1,10000,g4,BigFloat))

#Suma g1
#Zwykła suma w naturalnej kolejności
push!(results_g1, normal_sum(1,10000,g1,Float32))
push!(results_g1, normal_sum(1,10000,g1,Float64))

#Zwykła suma w odwrotnej kolejności
push!(results_g1, normal_sum(10000,1,g1,Float32))
push!(results_g1, normal_sum(10000,1,g1,Float64))

#Suma obliczona za pomoca algorytmu sumowania z poprawkami
push!(results_g1, Kahan_sum(1,10000,g1,Float32))
push!(results_g1, Kahan_sum(1,10000,g1,Float64))


#Suma g2
#Zwykła suma w naturalnej kolejności
push!(results_g2, normal_sum(1,10000,g2,Float32))
push!(results_g2, normal_sum(1,10000,g2,Float64))

#Zwykła suma w odwrotnej kolejności
push!(results_g2, normal_sum(10000,1,g2,Float32))
push!(results_g2, normal_sum(10000,1,g2,Float64))

#Suma obliczona za pomoca algorytmu sumowania z poprawkami
push!(results_g2, Kahan_sum(1,10000,g2,Float32))
push!(results_g2, Kahan_sum(1,10000,g2,Float64))


#Suma g3
#Zwykła suma w naturalnej kolejności
push!(results_g3, normal_sum(1,10000,g3,Float32))
push!(results_g3, normal_sum(1,10000,g3,Float64))

#Zwykła suma w odwrotnej kolejności
push!(results_g3, normal_sum(10000,1,g3,Float32))
push!(results_g3, normal_sum(10000,1,g3,Float64))

#Suma obliczona za pomoca algorytmu sumowania z poprawkami
push!(results_g3, Kahan_sum(1,10000,g3,Float32))
push!(results_g3, Kahan_sum(1,10000,g3,Float64))

#Suma g4
#Zwykła suma w naturalnej kolejności
push!(results_g4, normal_sum(1,10000,g4,Float32))
push!(results_g4, normal_sum(1,10000,g4,Float64))

#Zwykła suma w odwrotnej kolejności
push!(results_g4, normal_sum(10000,1,g4,Float32))
push!(results_g4, normal_sum(10000,1,g4,Float64))

#Suma obliczona za pomoca algorytmu sumowania z poprawkami
push!(results_g4, Kahan_sum(1,10000,g4,Float32))
push!(results_g4, Kahan_sum(1,10000,g4,Float64))



exact_num_g1 = Float64[]
exact_num_g2 = Float64[]
exact_num_g3 = Float64[]
exact_num_g4 = Float64[]
for i in 2:7
    push!(exact_num_g1, exact_number(results_g1[1], results_g1[i]))
    push!(exact_num_g2, exact_number(results_g2[1], results_g2[i]))
    push!(exact_num_g3, exact_number(results_g3[1], results_g3[i]))
    push!(exact_num_g4, exact_number(results_g4[1], results_g4[i]))
end

grid(zorder=0, alpha = 0.5)
barh(results[2:7], exact_num_g1,color = "c",zorder = 3)
savefig("../doc/figura1")
close()

grid(zorder=0, alpha = 0.5)
barh(results[2:7], exact_num_g2,color = "green",zorder = 3)
savefig("../doc/figura2")
close()

grid(zorder=0, alpha = 0.5)
barh(results[2:7], exact_num_g3,zorder = 3)
savefig("../doc/figura3")
close()

grid(zorder=0, alpha = 0.5)
barh(results[2:7], exact_num_g4,zorder = 3, color = "gray")
savefig("../doc/figura4")



