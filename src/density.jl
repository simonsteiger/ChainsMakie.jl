@recipe(ChainsDensity) do scene
    Attributes(
        color = Makie.wong_colors(),
        strokewidth = 1,
        alpha = 0.4,
    )
end

function Makie.plot!(cd::ChainsDensity{<:Tuple{<:AbstractMatrix}})
    mat = cd[1]
    
    if size(mat[], 2) > length(cd.color[])
        throw(error("Specify at least as many colors as there are chains."))
    end
    
    for (i, ys) in enumerate(eachcol(mat[]))
        density!(cd, ys; color = (cd.color[][i], cd.alpha[]),
                 strokecolor = cd.color[][i], strokewidth = cd.strokewidth[])
    end
    
    return cd
end

# TODO adjust decoration hiding based on loop
function Makie.density(chains::Chains, parameters; hidey=true, kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter) # FIXME don't do this hidex hidey thing
        chainsdensity!(chains[:, parameter, :]; kwargs...)
    end
    return fig
end
