@recipe(TracePlot) do scene
    Attributes(
        color = nothing, # TODO define a safe way to map custom colors -- maybe take `colormap` instead?
        linewidth = 1.5,
    )
end

function Makie.plot!(tp::TracePlot{<:Tuple{<:AbstractMatrix}})
    mat = tp[1]
    nsamples = size(mat[], 1)
    for chain in eachcol(mat[]) # FIXME breaking interactivity?
        lines!(tp, 1:nsamples, chain; linewidth = tp.linewidth)
    end
    return tp
end

function traceplot(chains::Chains, parameters; kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1], ylabel = string(parameter)) # Or another method where parameters::Symbol? Unnecessary?
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
