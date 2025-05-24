function Makie.plot(chains::Chains; figure = nothing)
    parameters = names(chains)
    _, nparams, nchains = size(chains)
    color = get_colors(nchains)
    
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains))
    end
    
    for i in 1:nparams * 2
        coord = fldmod1(i, 2)
        param_idx = first(coord)

        mat = chains[:, param_idx, :]
        ax = Axis(figure[coord...])
        if iszero(i % 2)
            all(isinteger, mat) ? chainsbarplot!(mat; color) : chainsdensity!(mat; color)
        else
            traceplot!(mat; color)
            ax.ylabel = string(parameters[param_idx])
        end
        
        if param_idx < nparams
            hidexdecorations!(ax; grid = false, ticklabels = false, ticks = false)
        else
            ax.xlabel = iszero(i % 2) ? "Parameter estimate" : "Iteration"
        end

        hideydecorations!(ax; label = false)
    end

    chainslegend(figure, chains, color)
    
    return figure
end

function Makie.plot(chains::Chains, f::Vararg{Function,N}; figure = nothing) where N
    # TODO convert the tuple to mutating functions if they aren't already
    parameters = names(chains)
    _, nparams, nchains = size(chains)
    color = get_colors(nchains)
    
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains))
    end
    
    for i in 1:nparams * length(f)
        coord = fldmod1(i, length(f))
        param_idx = first(coord)

        mat = chains[:, param_idx, :]
        ax = Axis(figure[coord...])

        for j in eachindex(f)
            if i % length(f) == j
                f[j](mat; color)
            end
        end
        i % length(f) == 0 && last(f)(mat; color)
        
        if i % length(f) == 1
            ax.ylabel = string(parameters[param_idx])
        end
        
        #=
        if param_idx < nparams
            hidexdecorations!(ax; grid = false, ticklabels = false, ticks = false)
        else
            ax.xlabel = iszero(i % 2) ? "Parameter estimate" : "Iteration"
        end
        =#

        hideydecorations!(ax; label = false)
    end

    chainslegend(figure, chains, color)
    
    return figure
end
