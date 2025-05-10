function Makie.plot(chains::Chains; size = nothing, hidey = false)
    parameters = names(chains)
    n_params = length(parameters)
    
    if isnothing(size)
        size = (600, n_params * 200)
    end
    fig = Figure(; size)
    
    for i in 1:n_params * 2
        coord = fldmod1(i, 2)
        param_idx = first(coord)

        mat = chains[:, param_idx, :]
        ax = Axis(fig[coord...])
        if iszero(i % 2)
            all(isinteger, mat) ? chainsbarplot!(mat) : chainsdensity!(mat)
        else
            traceplot!(mat)
        end
        
        if param_idx < n_params
            hidexdecorations!(ax; grid=false, ticklabels=false, ticks=false)
        else
            ax.xlabel = _xlabel(i)
        end

        if hidey
            ax.ylabel = ylabel
        end
        hideydecorations!(ax; label=false)
    end
    
    # The currently shown Makie code on MCMCChains.jl links axes
    # but sometimes the value ranges for different params differ a lot
    axes = [only(contents(fig[i, 2])) for i in 1:n_params]
    #linkxaxes!(axes...)
    
    return fig
end
