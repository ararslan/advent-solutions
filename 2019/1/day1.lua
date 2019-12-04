function read_input(file)
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = tonumber(line)
    end
    return lines
end

function fuel(mass)
    return math.max(0, math.floor(mass / 3) - 2)
end

function total_fuel(mass)
    local total = 0
    while mass > 0 do
        mass = fuel(mass)
        total = total + mass
    end
    return total
end

function main()
    local input = read_input("input")
    local fuel_sum = 0
    local total_sum = 0
    for _, mass in ipairs(input) do
        fuel_sum = fuel_sum + fuel(mass)
        total_sum = total_sum + total_fuel(mass)
    end
    print("Part 1 answer: ", fuel_sum)
    print("Part 2 answer: ", total_sum)
    return
end

main()
