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

function get_colors(nchains)
    if nchains > 7
        colormap = Makie.to_colormap(:viridis)
        idx = round.(Int, collect(range(1, length(colormap), length = nchains)))
        return colormap[idx]
    end
    return Makie.wong_colors()[1:nchains]
end

function chainslegend(fig, chains, colors)
    _, nparams, nchains = size(chains)
    
    elems = [PolyElement(color = (color, 0.8)) for color in colors]
    labels = [string(i) for i in 1:nchains]
    
    colpos = last(size(fig.layout)) > 1 ? range(1, 2) : 1
    
    Legend(fig[nparams + 1, colpos], elems, labels, "Chain",
        orientation = :horizontal, nbanks = nbanks(chains))
    
    return nothing
end

function autosize(chains)
    axis_size = 200
    legend_size = 40 + nbanks(chains) * 20
    return (600, size(chains, 2) * axis_size + legend_size)
end

nbanks(chains; per_bank = 5)::Int64 = ceil(size(chains, 3) / per_bank)
