function _axisdecorations!(ax, hidex, xlabel, hidey, ylabel)
    if hidey
        ax.ylabel = ylabel
    end
    hideydecorations!(ax; label=false)
    if hidex
        hidexdecorations!(ax; grid=false)
    else
        ax.xlabel = xlabel
    end
    return ax
end

sdim(i) = v -> map(x -> x[i], v)

function get_colors(n; colormap = :viridis, threshold = 7)
    if n > threshold
        colormap = Makie.to_colormap(colormap)
        idx = round.(Int, collect(range(1, length(colormap), length = n)))
        return colormap[idx]
    end
    return Makie.wong_colors()[1:n]
end

function chainslegend(fig, chains, colors)
    _, nparams, nchains = size(chains)
    
    elems = [PolyElement(; color) for color in colors]
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
