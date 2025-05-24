@recipe(TracePlot) do scene
    Attributes(
        color = Makie.wong_colors(),
        linewidth = 1.5,
    )
end

function Makie.plot!(tp::TracePlot{<:Tuple{<:AbstractMatrix}})
    mat = tp[1]
    xs = lift(m -> 1:size(m, 1), mat)
    
    if size(mat[], 2) > length(tp.color[])
        throw(error("Specify at least as many colors as there are chains."))
    end

    for (i, ys) in enumerate(eachcol(to_value(mat))) # FIXME interactivity?
        lines!(tp, xs, ys; linewidth = tp.linewidth, color = (to_value(tp.color)[i], 0.8))
    end
    
    return tp
end

# TODO adjust decoration hiding based on loop
function traceplot(chains::Chains, parameters; figure = nothing, kwargs...)
    color = get_colors(size(chains[:, parameters, :], 3))

    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end

    for (i, parameter) in enumerate(parameters)
        ax = Axis(figure[i, 1], ylabel = string(parameter))
        
        traceplot!(chains[:, parameter, :]; kwargs...)
        
        hideydecorations!(ax; label=false)
        if i < length(parameters)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Iteration"
        end    
    end

    chainslegend(figure, chains[:, parameters, :], color)
    
    return figure
end
