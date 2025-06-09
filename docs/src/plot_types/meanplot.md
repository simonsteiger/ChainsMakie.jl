```@meta
CurrentModule = ChainsMakie
```

# `meanplot`

A `meanplot` shows the running average of the samples for each chain and parameter.

Plotting the running average shows when, if at all, each of the chains has converged to the stationary distribution around the true parameter mean.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = meanplot(chains)
fig
```

## Attributes

### `color`

Specifies the `color`s to be used for coloring the running average of each chain.

Defaults to Makie's [`wong_colors`](https://docs.makie.org/dev/explanations/colors#Colormaps) palette and automatically switches to [`colormap = :viridis`](https://docs.makie.org/dev/explanations/colors#Colormaps) for more than seven chains.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = meanplot(chains; color = first(Makie.to_colormap(:tab20), 3))
fig
```

### `colormap`

Specifies the `colormap` to be used for coloring the running average of each chain.

Defaults to `:viridis`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 8), [:A, :B])
fig = meanplot(chains; colormap = :plasma)
fig
```

### `linewidth`

Controls the `linewidth` of each line.

### `alpha`

Controls the opacity of each line.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = meanplot(chains; linewidth = 0.0, alpha = 0.8)
fig
```
