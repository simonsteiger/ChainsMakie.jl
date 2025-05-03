using CairoMakie, MCMCChains

chns = Chains(randn(300, 5, 3), [:A, :B, :C, :D, :E])

function axisdecorations!(ax, hidex, xlabel, ylabel, parameter)
    if ylabel
        ax.ylabel = parameter
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

function Makie.density(chains::Chains, parameters; showylabel=true, kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1])
        hidex = i < length(parameters)
        axisdecorations!(ax, hidex, "Parameter estimate", showylabel, parameter)
        density!(chains[:, parameter, :]; kwargs...)
    end
    return fig
end

function Makie.density!(axs::Vector{Axis}, chains::Chains, parameters; showylabel=true)
    if length(axs) != length(parameters)
        error(DimensionMismatch("`axs` and `parameters` must be the same length"))
    end
    for (i, (ax, parameter)) in enumerate(zip(axs, parameters))
        hidex = i < length(parameters)
        axisdecorations!(ax, hidex, "Parameter estimate", showylabel, parameter)
        # TODO access the color cycler here and add alpha to fill
        density!(ax, chains[:, parameter, :]; strokearound = true)
    end
    return nothing
end

fig = density(chns, ["A", "B"])

fig = Figure()
parameters = ["A", "C"]
axs = [Axis(fig[i, 1]) for i in eachindex(parameters)]
density!(axs, chns, parameters)

