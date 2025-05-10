@recipe(ChainsHist) do scene
    Attributes(
        color = nothing, # TODO define a safe way to map custom colors -- maybe take `colormap` instead?
        bins = 15,
    )
end

function Makie.plot!(md::ChainsHist{<:Tuple{<:AbstractMatrix}})
    mat = md[1]
    for chain in eachcol(mat[])
        hist!(md, chain)
    end
    return md
end

function Makie.hist(chains::Chains, parameters; hidey=true, kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter)
        chainshist!(chains[:, parameter, :]; kwargs...)
    end
    return fig
end
