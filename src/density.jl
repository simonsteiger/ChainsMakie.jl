@recipe(ChainsDensity) do scene
    Attributes(
        color = nothing, # TODO define a safe way to map custom colors -- maybe take `colormap` instead?
    )
end

function Makie.plot!(md::ChainsDensity{<:Tuple{<:AbstractMatrix}})
    mat = md[1]
    for (i, chain) in enumerate(eachcol(mat[]))
        density!(md, chain)
    end
    return md
end

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
