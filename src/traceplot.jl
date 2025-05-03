@recipe(TracePlot) do scene
    Attributes(
        color = nothing, # TODO define a safe way to map custom colors
        linewidth = 1.5,
    )
end

function Makie.plot!(tp::TracePlot{<:Tuple{<:AbstractMatrix}})
    mat = tp[1]
    n_samples = size(mat[], 1)
    for chain in eachcol(mat[])
        lines!(tp, 1:n_samples, chain; linewidth = tp.linewidth)
    end
    return tp
end

function traceplot(chains::Chains, parameters; kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1], ylabel = parameter)
        traceplot!(chains[:, parameter, :]; kwargs...)
    
        hideydecorations!(ax; label=false)
        if i < length(parameters)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Iteration"
        end    
    end
    
    return fig
end
