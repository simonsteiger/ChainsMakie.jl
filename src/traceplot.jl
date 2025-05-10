@recipe(TracePlot) do scene
    Attributes(
        color = nothing, # TODO define a safe way to map custom colors -- maybe take `colormap` instead?
        linewidth = 1.5,
    )
end

function Makie.plot!(tp::TracePlot{<:Tuple{<:AbstractMatrix}})
    mat = tp[1]
    
    xs = lift(m -> 1:size(m, 1), mat)
    for ys in eachcol(to_value(mat)) # FIXME interactivity?
        lines!(tp, xs, ys; linewidth = tp.linewidth)
    end

    return tp
end

function traceplot(chains::Chains, parameters; kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1], ylabel = string(parameter))
        
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
