parselist(s::AbstractString) = map(x->(x[1], parse(Int, x[2:end])), split(s, ','))

const path1, path2 = map(parselist, eachline("input"))

manhatten((x, y)::Tuple{Int,Int}) = abs(x) + abs(y)  # from the origin

function trace(path::AbstractVector)
    points = Dict{Tuple{Int,Int},Int}()
    i = j = traveled = 0
    for (direction, distance) in path, step in 1:distance
        traveled += 1
        if direction === 'R'
            i += 1
        elseif direction === 'L'
            i -= 1
        elseif direction === 'U'
            j -= 1
        elseif direction === 'D'
            j += 1
        end
        get!(points, (i, j), traveled)
    end
    return points
end

function main(path1, path2)
    points1 = trace(path1)
    points2 = trace(path2)
    crosses = intersect(keys(points1), keys(points2))
    distance = minimum(manhatten, crosses)
    println("Part 1 answer: ", distance)
    steps = minimum(p->points1[p] + points2[p], crosses)
    println("Part 2 answer: ", steps)
end

main(path1, path2)
