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
# so there will be integration problems with `plot(chains, funs...)`
# The rest require a color vector which has length == size(chains, 1)
# Here it is size(chains, 1) * size(chains, 2)
function Makie.violin!(chains::Chains, parameters; color = :default, kwargs...)
    fig = current_figure()

    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1], ylabel = string(parameter))
        
        hideydecorations!(ax; label=false)
        if i < length(parameters)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Chain"
        end

        if color == :default
            colors = get_colors(size(chains, 2); color)
            color_per_value = repeat(colors, inner = size(chains, 1))
            violin!(chains[:, parameter, :]; color = color_per_value, kwargs...)
            continue
        end

        color_per_value = repeat(first(color, size(chains, 2)), inner = size(chains, 1))
        violin!(chains[:, parameter, :]; color = color_per_value, kwargs...)
    end

    return fig
end

Makie.violin(chains::Chains; kwargs...) = violin(chains, names(chains); kwargs...)
Makie.violin!(chains::Chains; kwargs...) = violin!(chains, names(chains); kwargs...)
