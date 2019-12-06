using LightGraphs

function build_graph(file::AbstractString)
    objects = Set{String}()
    for line in eachline(file), object in split(line, ')')
        push!(objects, object)
    end
    vertex_map = Dict(object => i for (i, object) in enumerate(objects))
    graph = SimpleDiGraph(length(objects))
    for line in eachline(file)
        a, b = split(line, ')')
        add_edge!(graph, vertex_map[a], vertex_map[b])
    end
    (graph, vertex_map)
end

function main(input)
    directed_graph, vertex_map = build_graph(input)
    i = first(first(attracting_components(reverse(directed_graph))))
    println("Part 1 answer: ", sum(gdistances(directed_graph, i)))

    graph = SimpleGraph(directed_graph)
    you = vertex_map["YOU"]
    you_parent = first(outneighbors(graph, you))
    santa = vertex_map["SAN"]
    santa_parent = first(outneighbors(graph, santa))
    println("Part 2 answer: ", length(a_star(graph, you_parent, santa_parent)))
end

main("input")
