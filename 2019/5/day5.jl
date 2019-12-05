using OffsetArrays

const program = OffsetVector(parse.(Int, split(readchomp("input"), ',')), -1)

retrieve(program::AbstractVector, x::Integer, mode::Integer) =
    mode == 0 ? program[x] :
    mode == 1 ? x :
    error("unrecognized mode $mode")

function run!(program::AbstractVector, input::AbstractVector)
    output = Int[]
    pos = 0
    while pos < length(program) - 1 && program[pos] != 99
        code = digits(program[pos], pad=5)
        opcode, _, mode1, mode2, mode3 = code
        @assert mode3 == 0
        if opcode == 1
            a, b, c = program[pos+1:pos+3]
            program[c] = retrieve(program, a, mode1) + retrieve(program, b, mode2)
            pos += 4
        elseif opcode == 2
            a, b, c = program[pos+1:pos+3]
            program[c] = retrieve(program, a, mode1) * retrieve(program, b, mode2)
            pos += 4
        elseif opcode == 3
            program[program[pos+1]] = pop!(input)
            pos += 2
        elseif opcode == 4
            push!(output, retrieve(program, program[pos+1], mode1))
            pos += 2
        elseif opcode == 5
            if retrieve(program, program[pos+1], mode1) > 0
                pos = retrieve(program, program[pos+2], mode2)
            else
                pos += 3
            end
        elseif opcode == 6
            if retrieve(program, program[pos+1], mode1) == 0
                pos = retrieve(program, program[pos+2], mode2)
            else
                pos += 3
            end
        elseif opcode == 7
            a, b, c = program[pos+1:pos+3]
            program[c] = Int(retrieve(program, a, mode1) < retrieve(program, b, mode2))
            pos += 4
        elseif opcode == 8
            a, b, c = program[pos+1:pos+3]
            program[c] = Int(retrieve(program, a, mode1) == retrieve(program, b, mode2))
            pos += 4
        else
            error("unexpected opcode $opcode as position $pos")
        end
    end
    return output
end

println("Part 1 answer: ", last(run!(copy(program), [1])))
println("Part 2 answer: ", last(run!(copy(program), [5])))
