@recipe(ChainsDensity) do scene
    Attributes(
        color = :default,
        colormap = :default,
        strokewidth = 1,
        alpha = 0.4,
    )
end

function Makie.plot!(cd::ChainsDensity{<:Tuple{<:AbstractMatrix}})
    mat = cd[1]
    color = get_colors(size(mat[], 2); color = cd.color[], colormap = cd.colormap[])
    
    for (i, ys) in enumerate(eachcol(mat[]))
        density!(cd, ys; color = (color[i], cd.alpha[]),
                 strokecolor = color[i], strokewidth = cd.strokewidth[])
    end
    
    return cd
end

# FIXME drop `_axisdecorations!`
function Makie.density(chains::Chains, parameters; figure = nothing, hidey=true, kwargs...)
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end

    for (i, parameter) in enumerate(parameters)
        ax = Axis(figure[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter) # FIXME don't do this hidex hidey thing
        chainsdensity!(chains[:, parameter, :]; kwargs...)
    end

    color = get_colors(size(chains[:, parameters, :], 3); kwargs...)
    chainslegend(figure, chains[:, parameters, :], color)

    return figure
end
