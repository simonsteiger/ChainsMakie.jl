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
