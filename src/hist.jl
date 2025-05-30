@recipe(ChainsHist) do scene
    Attributes(
        color = :default,
        colormap = :default,
        bins = 15,
        alpha = 0.4,
        linewidth = 1.5,
    )
end

function Makie.plot!(ch::ChainsHist{<:Tuple{<:AbstractMatrix}})
    mat = ch[1]
    color = get_colors(size(mat[], 2); color = ch.color[], colormap = ch.colormap[])
    
    for (i, ys) in enumerate(eachcol(to_value(mat)))
        hist!(ch, ys; color = (color[i], ch.alpha[]), bins = ch.bins[])
        stephist!(ch, ys; bins = ch.bins[], color = color[i], linewidth = ch.linewidth[])
    end
    
    return ch
end

function Makie.hist(chains::Chains, parameters; figure = nothing, hidey=true, kwargs...)
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end

    for (i, parameter) in enumerate(parameters)
        ax = Axis(figure[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter) # FIXME don't do this hidex hidey thing
        chainshist!(chains[:, parameter, :]; kwargs...)
    end

    color = get_colors(size(chains[:, parameters, :], 3); kwargs...)
    chainslegend(figure, chains[:, parameters, :], color)

    return figure
end

Makie.hist(chains::Chains; kwargs...) = hist(chains, names(chains); kwargs...)
