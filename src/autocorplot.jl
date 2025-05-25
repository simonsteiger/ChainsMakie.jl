@recipe(AutocorPlot) do scene
    Attributes(
        color = :default,
        colormap = :default,
        lags = 0:20,
        linewidth = 1.5,
        alpha = 1.0,
    )
end

function Makie.plot!(ap::AutocorPlot{<:Tuple{<:AbstractMatrix}})
    mat = ap[1]
    color = get_colors(size(mat[], 2); color = ap.color[], colormap = ap.colormap[])

    autocormat = lift(mat, ap.lags) do mat, lags
        StatsBase.autocor(mat, lags)
    end

    for (i, ys) in enumerate(eachcol(autocormat[])) # FIXME interactivity?
        lines!(ap, ap.lags, ys; linewidth = ap.linewidth, color = (color[i], ap.alpha[]))
    end
    
    return ap
end

function autocorplot(chains::Chains, parameters; figure = nothing, kwargs...)
    color = get_colors(size(chains[:, parameters, :], 3); kwargs...)

    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end

    for (i, parameter) in enumerate(parameters)
        ax1 = Axis(figure[i, 1], ylabel = string(parameter))
        ax2 = Axis(figure[i, 1], ylabel = "Autocorrelation", yaxisposition = :right)
        
        autocorplot!(chains[:, parameter, :]; kwargs...)
        
        hideydecorations!(ax1; label=false)
        hidexdecorations!(ax1)
        if i < length(parameters)
            hidexdecorations!(ax2; grid=false)
        else
            ax2.xlabel = "Lag"
        end    
    end

    color = get_colors(size(chains[:, parameters, :], 3); kwargs...)
    chainslegend(figure, chains[:, parameters, :], color)
    
    return figure
end

