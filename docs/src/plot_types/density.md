```@meta
CurrentModule = ChainsMakie
```

# `density`

A [`density`](@ref) plot of `Chains` shows the [kernel density estimate](https://en.wikipedia.org/wiki/Kernel_density_estimation) of the samples in each chain.

Density plots are a useful summary of both the shapes of distributions for each chain, and their location, highlighting potential convergence issues.
Together with [`traceplot`](@ref)s, they a part of the most common summary visualization of MCMC chains (see [`plot`](@ref)).

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = density(chains)
fig
```

## Attributes

### `color`

Controls which `color`s will be used to color the `density` plot for each chain.

Defaults to Makie's [`wong_colors`](https://docs.makie.org/dev/explanations/colors#Colormaps) palette and automatically switches to [`colormap = :viridis`](https://docs.makie.org/dev/explanations/colors#Colormaps) for more than seven chains.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = density(chains; color = first(Makie.to_colormap(:tab20), 4))
fig
```

### `colormap`

Controls which `colormap` will be used to color the `density` plot for each chain.

Defaults to the `:viridis` palette.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains
chains = Chains(randn(300, 2, 8), [:A, :B])
fig = density(chains; colormap = :plasma)
fig
```

### `strokewidth`

Controls the `strokewidth` of the density plot's contour.

Defaults to `1.0`.

### `alpha`

Controls the opacity of the density plot.

Defaults to `0.4`.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = density(chains; strokewidth = 0.0, alpha = 0.8)
fig
```
