"""
    chainshist(matrix)

Plots the histogram of the samples for an iteration × chain `matrix`.

## Attributes
WIP

## Example

```julia
using CairoMakie, ChainsMakie, MCMCChains
chains = Chains(randn(300, 3, 3), [:A, :B, :C])
chainshist(chains)
```
"""
@recipe(ChainsHist) do scene
    Attributes(
        color = :default,
        colormap = :default,
        bins = 15,
        alpha = 0.4,
        linewidth = 1.5,
    )
end

function Makie.plot!(ch::ChainsHist{<:Tuple{<:AbstractMatrix}})
    mat = ch[1]
    color = get_colors(size(mat[], 2); color = ch.color[], colormap = ch.colormap[])
    
    for (i, ys) in enumerate(eachcol(to_value(mat)))
        hist!(ch, ys; color = (color[i], ch.alpha[]), bins = ch.bins[])
        stephist!(ch, ys; bins = ch.bins[], color = color[i], linewidth = ch.linewidth[])
    end
    
    return ch
end

# Type piracy, I own neither `hist` nor `Chains`?
"""
    hist(chains)
    hist(chains, parameters)

Plots the histogram of the samples for each chain and parameter.

## Attributes
WIP

## Example

```julia
using CairoMakie, ChainsMakie, MCMCChains
chains = Chains(randn(300, 3, 3), [:A, :B, :C])
hist(chains)
```
"""
function Makie.hist(chains::Chains, parameters; figure = nothing, color = :default,
    colormap = :default, bins = 15, alpha = 0.4, linewidth = 1.5)
    
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
        
        chainshist!(chains[:, parameter, :]; color, colormap, bins, alpha, linewidth)
    end

    colors = get_colors(size(chains[:, parameters, :], 3); color, colormap)
    chainslegend(figure, chains[:, parameters, :], colors)

    return figure
end

Makie.hist(chains::Chains; kwargs...) = hist(chains, names(chains); kwargs...)
