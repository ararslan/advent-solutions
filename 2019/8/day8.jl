const image = let raw = read("input")
    last(raw) === 0x0a && pop!(raw)  # remove trailing newline
    raw
end

function part1(image)
    layers = collect(Iterators.partition(image, 25 * 6))
    i = argmin(map(x->count(==(0x30), x), layers))
    println("Part 1 answer: ", count(==(0x31), layers[i]) * count(==(0x32), layers[i]))
end

function firstcolor(slice::AbstractVector{UInt8})
    for i = 1:length(slice)
        x = slice[i]
        if x === 0x30 || x === 0x31
            return x
        end
    end
    0x32
end

function part2(image)
    # Do this little dance to get a row-major `reshape`
    X = permutedims(reshape(image, 25, 6, :), (2, 1, 3))
    println("Part 2 answer: ")
    for i = 1:6
        for j = 1:25
            c = firstcolor(view(X, i, j, :))
            print(c === 0x30 ? ' ' : '#')
        end
        println()
    end
end

part1(image)
part2(image)
