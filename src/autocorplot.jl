@recipe(AutocorPlot) do scene
    Attributes(
        color = Makie.wong_colors(),
        lags = 0:20,
        linewidth = 1.5,
        alpha = 1.0,
    )
end

function Makie.plot!(ap::AutocorPlot{<:Tuple{<:AbstractMatrix}})
    mat = ap[1]
    
    if size(mat[], 2) > length(ap.color[])
        error("Specify at least as many colors as there are chains.")
    end

    autocormat = lift(mat, ap.lags) do mat, lags
        StatsBase.autocor(mat, lags)
    end

    for (i, ys) in enumerate(eachcol(autocormat[])) # FIXME interactivity?
        lines!(ap, ap.lags, ys; linewidth = ap.linewidth, 
            color = (to_value(ap.color)[i], ap.alpha[]))
    end
    
    return ap
end

function autocorplot(chains::Chains, parameters; kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1], ylabel = "Autocorrelation")
        
        autocorplot!(chains[:, parameter, :]; kwargs...)

        # TODO find a way to also label the parameter, maybe something like top right in axis?
        
        if i < length(parameters)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Lag"
        end    
    end
    
    return fig
end

