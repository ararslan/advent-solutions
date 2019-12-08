using OffsetArrays
using Combinatorics
using Base: RefValue

const program = OffsetVector(parse.(Int, split(readchomp("input"), ',')), -1)

struct Machine
    memory::OffsetArray{Int,1,Vector{Int}}
    ip::RefValue{Int}
end

Machine(program::AbstractVector, ip::Integer=0) = Machine(program, Ref(ip))

retrieve(program::AbstractVector, x::Integer, mode::Integer) =
    mode == 0 ? program[x] :
    mode == 1 ? x :
    error("unrecognized mode $mode")

function (m::Machine)(input::Channel{Int}, output::Channel{Int})
    program = m.memory
    pos = m.ip[]
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
            isready(input) || wait(input)
            program[program[pos+1]] = take!(input)
            pos += 2
        elseif opcode == 4
            put!(output, retrieve(program, program[pos+1], mode1))
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
    m.ip[] = pos
    nothing
end

struct Amplifier
    machine::Machine
    phase::Int
    input::Channel{Int}
    output::Channel{Int}
end

function (amp::Amplifier)(input::Integer)
    put!(amp.input, amp.phase)
    put!(amp.input, input)
    amp.machine(amp.input, amp.output)
    take!(amp.output)
end

function part1(program)
    best = maximum(permutations(0:4)) do phases
        channels = [Channel{Int}(Inf) for _ in 1:6]
        mapfoldr((f, x)->f(x), 1:5, init=0) do i
            Amplifier(Machine(copy(program)), phases[i], channels[i], channels[i+1])
        end
    end
    println("Part 1 answer: ", best)
end

function part2(program)
    best = maximum(permutations(5:9)) do phases
        channels = [Channel{Int}(Inf) for _ in 1:5]
        amps = Vector{Amplifier}(undef, 5)
        for i = 1:5
            amps[i] = Amplifier(Machine(copy(program)), phases[i],
                                channels[i], channels[mod1(i+1,5)])
            put!(channels[i], phases[i])
        end
        put!(channels[1], 0)
        tasks = [@async(amps[i].machine(amps[i].input, amps[i].output)) for i = 1:5]
        wait(tasks[1])
        take!(channels[1])
    end
    println("Part 2 answer: ", best)
end

part1(program)
part2(program)
