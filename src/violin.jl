function Makie.convert_arguments(::Type{<:Violin}, m::MCMCChains.AxisMatrix)
    xs = repeat(axes(m, 2), inner = size(m, 1))
    ys = vec(m)
    return (xs, ys)
end

# Type piracy because ChainsMakie owns neither violin nor Chains
"""
    violin(chains)
    violin(chains, parameters)

Plots a violin plot of the distribution of samples for each of the `parameter` in `chains`.

## Attributes
WIP

## Example

```julia
using CairoMakie, ChainsMakie
import MCMCChains: Chains
chains = Chains(randn(300, 3, 3), [:A, :B, :C])
violin(chains)
```
"""
function Makie.violin(chains::Chains, parameters; kwargs...)
    fig = Figure(size = autosize(chains[:, parameters, :]))
    violin!(chains, parameters; kwargs...)
    return fig
end

# TODO this currently does not work with the way colors are passed
# to all the other functions in ChainsMakie
# so there will be integration problems with `plot(chains, funs...)` (once that happens)
# The rest require a color vector which has length == size(chains, 1)
# Here it is size(chains, 1) * size(chains, 2)
function Makie.violin!(chains::Chains, parameters; color = :default, orientation = :horizontal, link_x = false, kwargs...)
    fig = current_figure()

    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1], ylabel = string(parameter))

        if color == :default
            colors = get_colors(size(chains, 3); color)
            color_per_value = repeat(colors, inner = size(chains, 1))
            violin!(chains[:, parameter, :]; color = color_per_value, orientation, kwargs...)
        else
            color_per_value = repeat(first(color, size(chains, 3)), inner = size(chains, 1))
            violin!(chains[:, parameter, :]; color = color_per_value, orientation, kwargs...)
        end

        islast = length(parameters) == i
        setaxisdecorations!(ax, islast, "Parameter estimate", link_x)
    end

    colors = get_colors(size(chains[:, parameters, :], 3); color)
    chainslegend(fig, chains[:, parameters, :], colors)

    if link_x
        axes = [only(contents(fig[i, 1])) for i in eachindex(parameters)]
        linkxaxes!(axes...)
    end

    return fig
end

Makie.violin(chains::Chains; kwargs...) = violin(chains, names(chains); kwargs...)
Makie.violin!(chains::Chains; kwargs...) = violin!(chains, names(chains); kwargs...)
