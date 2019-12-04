using Combinatorics
using StatsBase

# Bounds: puzzle input
const LOWER = 387638
const UPPER = 919123

function int_from_digits(digits::AbstractVector)
    range = length(digits)-1:-1:0
    sum(@. digits * 10^range)
end

function countcombs(f)
    combs = Iterators.filter(f, with_replacement_combinations(1:9, 6))
    # Just iterate to avoid materializing a large array
    n = 0
    for c in combs
        n += 1
    end
    n
end

println("Part 1 answer: ", countcombs() do c
    issorted(c) && any(iszero, diff(c)) && LOWER ≤ int_from_digits(c) ≤ UPPER
end)

println("Part 2 answer: ", countcombs() do c
    issorted(c) && LOWER ≤ int_from_digits(c) ≤ UPPER && any(==(2), last(rle(c)))
end)
