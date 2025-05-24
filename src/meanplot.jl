@recipe(MeanPlot) do scene
    Attributes(
        color = Makie.wong_colors(),
        linewidth = 1.5,
        alpha = 1.0,
    )
end

function Makie.plot!(mp::MeanPlot{<:Tuple{<:AbstractMatrix}})
    mat = mp[1]

    if size(mat[], 2) > length(mp.color[])
        throw(error("Specify at least as many colors as there are chains."))
    end
    
    for (i, vals) in enumerate(eachcol(to_value(mat)))
        ys = MCMCChains.cummean(vals)
        lines!(mp, ys; color = (mp.color[][i], mp.alpha[]))
    end
    
    return mp
end

function meanplot(chains::Chains, parameters; figure = nothing, kwargs...)
    color = get_colors(size(chains[:, parameters, :], 3))

    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end
    
    for (i, parameter) in enumerate(parameters)
        ax = Axis(figure[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Iteration", true, parameter) # FIXME don't do this hidex hidey thing
        meanplot!(chains[:, parameter, :]; kwargs...)
    end

    chainslegend(figure, chains[:, parameters, :], color)

    return figure
end
