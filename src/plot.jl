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
    for f_i in string.(f)
        endswith(f_i, "!") || 
            error("All functions in `f` must be mutating; pass `$(f_i)!` instead.")
    end

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

        
        if i % length(f) == 1
            ax.ylabel = string(parameters[param_idx])
        end
        hideydecorations!(ax; label = false)

        if param_idx < nparams
            hidexdecorations!(ax; grid = false, ticklabels = false, ticks = false)
        end

        if i % length(f) == 0
            last(f)(mat; color)
            ax.xlabel = last(_xlabel(f))
            continue
        end

        for j in eachindex(f)
            if i % length(f) == j
                f[j](mat; color)
                ax.xlabel = _xlabel(f)[j]
            end
        end
    end

    per_bank = length(f) > 2 ? 8 : 5
    chainslegend(figure, chains, color; per_bank)
    
    return figure
end

function _xlabel(f)
    f_string = map(s -> replace(s, "!" => ""), string.(f))
    
    label_dict = Dict(
        "chainsdensity" => "Parameter estimate",
        "chainshist" => "Parameter estimate",
        "traceplot" => "Iteration",
        "trankplot" => "Iteration",
        "meanplot" => "Iteration",
        "autocorplot" => "Lag",
    )

    out = String[]
    for f_i in f_string
        if haskey(label_dict, f_i)
            push!(out, label_dict[f_i])
            continue
        end
        error("Can't compose plot using $f_i.")
    end
    
    return out
end
