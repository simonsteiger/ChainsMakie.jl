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

_xlabel(i) = iszero(i % 2) ? "Parameter estimate" : "Iteration"
