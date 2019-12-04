fuel(mass::Real) = max(0, fld(mass, 3) - 2)

const input = map(x->parse(Int, x), eachline("input"))

println("Part 1 answer: ", sum(fuel, input))

function totfuel(mass::Real)
    total = 0
    while mass > 0
        mass = fuel(mass)
        total += mass
    end
    total
end

println("Part 2 answer: ", sum(totfuel, input))
