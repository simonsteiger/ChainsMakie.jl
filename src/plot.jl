function Makie.plot(chains::Chains; figure = nothing, kwargs...)
    parameters = names(chains)
    _, nparams, nchains = size(chains)
    color = get_colors(nchains; kwargs...)
    
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains; ncols = 2))
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

function Makie.plot(chains::Chains, f::Vararg{Function,N}; figure = nothing, kwargs...) where N
    for f_i in string.(f)
        endswith(f_i, "!") ||
            error("All functions in `f` must be mutating; pass `$(f_i)!` instead.")
    end

    parameters = names(chains)
    _, nparams, nchains = size(chains)
    
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains; ncols = length(f)))
    end
    
    for i in 1:nparams * length(f)
        coord = fldmod1(i, length(f))
        param_idx = first(coord)

        mat = chains[:, param_idx, :]
        ax = Axis(figure[coord...])

        
        if i % length(f) == 1
            ax.ylabel = string(parameters[param_idx])
        end
        hideydecorations!(ax; label = false)

        if param_idx < nparams
            hidexdecorations!(ax; grid = false, ticklabels = false, ticks = false)
        end

        # TODO automatically switch to barplot for integer parameters
        if i % length(f) == 0
            last(f)(mat; kwargs...)
            ax.xlabel = last(_xlabel(f))
            continue
        end

        for j in eachindex(f)
            if i % length(f) == j
                f[j](mat; kwargs...)
                ax.xlabel = _xlabel(f)[j]
            end
        end
    end

    per_bank = length(f) > 2 ? 8 : 5
    color = get_colors(nchains; kwargs...)
    chainslegend(figure, chains, color; per_bank)
    
    return figure
end
