@recipe(ChainsBarPlot) do scene
    Attributes(
        color = nothing, # TODO define a safe way to map custom colors -- maybe take `colormap` instead?
        bins = 15,
    )
end

function Makie.plot!(bp::ChainsBarPlot{<:Tuple{<:AbstractMatrix}})
    mat = bp[1]
    all(isinteger, mat[]) || throw(error("Use `hist` continuous parameters."))
    for chain in eachcol(mat[])
        count_dict = countmap(chain)
        barplot!(bp, collect(keys(count_dict)), collect(values(count_dict)))
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
