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

function Makie.density!(ax::Axis, mat::AbstractMatrix; kwargs...)
    for i in axes(mat, 2)
        density!(ax, mat[:, i]; kwargs...)
    end
    return nothing
end

function Makie.density!(mat::AbstractMatrix; kwargs...)
    ax = current_axis()
    density!(ax, mat; kwargs...)
    return nothing
end

function Makie.density(chains::Chains, parameters; hidey=true, kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter)
        density!(chains[:, parameter, :]; kwargs...)
    end
    return fig
end

function Makie.density!(axs::Vector{Axis}, chains::Chains, parameters; hidey=true)
    if length(axs) != length(parameters)
        error(DimensionMismatch("`axs` and `parameters` must be the same length"))
    end
    for (i, (ax, parameter)) in enumerate(zip(axs, parameters))
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter)
        # TODO access the color cycler here and add alpha to fill
        density!(ax, chains[:, parameter, :]; strokearound = true)
    end
    return nothing
end
