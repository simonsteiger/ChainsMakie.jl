"""
    chainsdensity(matrix)

Plots the density of the samples for an iteration × chain `matrix`.

## Attributes
WIP

## Example

```julia
using CairoMakie, ChainsMakie, MCMCChains
chains = Chains(randn(300, 3, 3), [:A, :B, :C])
chainsdensity(chains[:, :B, :])
```
"""
@recipe(ChainsDensity) do scene
    Attributes(
        color = :default,
        colormap = :default,
        strokewidth = 1.0,
        alpha = 0.4,
    )
end

function Makie.plot!(cd::ChainsDensity{<:Tuple{<:AbstractMatrix}})
    mat = cd[1]
    color = get_colors(size(mat[], 2); color = cd.color[], colormap = cd.colormap[])
    
    for (i, ys) in enumerate(eachcol(mat[]))
        density!(cd, ys; color = (color[i], cd.alpha[]),
                 strokecolor = color[i], strokewidth = cd.strokewidth[])
    end
    
    return cd
end

# Type piracy, I own neither `density` nor `Chains`?
"""
    density(chains)
    density(chains, parameters)

Plots the density of the samples for each chain and parameter.

## Attributes
WIP

## Example

```julia
using CairoMakie, ChainsMakie, MCMCChains
chains = Chains(randn(300, 3, 3), [:A, :B, :C])
density(chains)
```
"""
function Makie.density(chains::Chains, parameters; figure = nothing, color = :default,
    colormap = :default, strokewidth = 1.0, alpha = 0.4)

    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end

    for (i, parameter) in enumerate(parameters)
        ax = Axis(figure[i, 1], ylabel = string(parameter))
        
        hideydecorations!(ax; label=false)
        if i < length(parameters)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Parameter estimate"
        end

        chainsdensity!(chains[:, parameter, :]; color, colormap, strokewidth, alpha)
    end

    colors = get_colors(size(chains[:, parameters, :], 3); color, colormap)
    chainslegend(figure, chains[:, parameters, :], colors)

    return figure
end

Makie.density(chains::Chains; kwargs...) = density(chains, names(chains); kwargs...)
