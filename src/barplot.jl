@recipe(ChainsBarPlot) do scene
    Attributes(
        color = Makie.wong_colors(),
        bins = 15,
    )
end

function Makie.plot!(bp::ChainsBarPlot{<:Tuple{<:AbstractMatrix}})
    mat = bp[1]

    if size(mat[], 2) > length(bp.color[])
        throw(error("Specify at least as many colors as there are chains."))
    end

    all(isinteger, mat[]) || throw(error("Use `hist` continuous parameters."))
    
    for (i, ys) in enumerate(eachcol(to_value(mat)))
        count_dict = countmap(ys)
        xs = collect(keys(count_dict))
        ys = collect(values(count_dict))
        barplot!(bp, xs, ys; color = to_value(bp.color)[i])
    end
    
    return bp
end

function Makie.barplot(chains::Chains, parameters; hidey=true, kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter)
        chainsbarplot!(chains[:, parameter, :]; kwargs...)
    end
    return fig
end
