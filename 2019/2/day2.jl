const program = parse.(Int, split(readchomp("input"), ','))

function run!(program::AbstractVector)
    pos = 1
    while pos < length(program) && program[pos] != 99
        opcode = program[pos]
        if opcode == 1
            op = +
        elseif opcode == 2
            op = *
        else
            error("unexpected opcode $opcode")
        end
        p1, p2, out = program[pos+1:pos+3] .+ 1
        program[min(out, end)] = op(program[p1], program[p2])
        pos += 4
    end
    return program
end

function output(input, noun, verb)
    program = copy(input)
    program[2] = noun
    program[3] = verb
    run!(program)
    return first(program)
end

part1(input) = println("Part 1 answer: ", output(input, 12, 2))

function part2(input, target)
    bound = 99
    noun = verb = -1
    for outer noun = 0:bound, outer verb = 0:bound
        output(input, noun, verb) == target && break
    end
    println("Part 2 answer: ", 100 * noun + verb)
end

part1(program)
part2(program, 19690720)
