@recipe(ChainsBarPlot) do scene
    Attributes(
        color = :default,
        colormap = :default,
        bins = 15,
    )
end

function Makie.plot!(bp::ChainsBarPlot{<:Tuple{<:AbstractMatrix}})
    mat = bp[1]
    color = get_colors(size(mat[], 2); color = bp.color[], colormap = bp.colormap[])

    all(isinteger, mat[]) || throw(error("Use `hist` continuous parameters."))
    
    for (i, ys) in enumerate(eachcol(to_value(mat)))
        count_dict = countmap(ys)
        xs = collect(keys(count_dict))
        ys = collect(values(count_dict))
        barplot!(bp, xs, ys; color = color[i])
    end
    
    return bp
end

# FIXME drop `_axisdecorations!`
function Makie.barplot(chains::Chains, parameters; figure = nothing, hidey=true, kwargs...)
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end

    for (i, parameter) in enumerate(parameters)
        ax = Axis(figure[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter) # FIXME don't do this hidex hidey thing
        chainsbarplot!(chains[:, parameter, :]; kwargs...)
    end

    color = get_colors(size(chains[:, parameters, :], 3); kwargs...)
    chainslegend(figure, chains[:, parameters, :], color)

    return figure
end
