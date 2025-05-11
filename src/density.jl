@recipe(ChainsDensity) do scene
    Attributes(
        color = Makie.wong_colors(),
    )
end

function Makie.plot!(cd::ChainsDensity{<:Tuple{<:AbstractMatrix}})
    mat = cd[1]
    # FIXME this currently breaks for > 7 chains! Error and tell user to specify more colors
    for (i, ys) in enumerate(eachcol(to_value(mat)))
        density!(cd, ys; color = (to_value(cd.color)[i], 0.8))
    end
    return cd
end

# TODO adjust decoration hiding based on loop
function Makie.density(chains::Chains, parameters; hidey=true, kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter)
        chainsdensity!(chains[:, parameter, :]; kwargs...)
    end
    return fig
end
