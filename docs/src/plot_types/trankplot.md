```@meta
CurrentModule = ChainsMakie
```

# `trankplot`

A [`trankplot`](@ref) shows the mean rank of samples per iteration bin for each chain and parameter connected by [`stairs`](https://docs.makie.org/dev/reference/plots/stairs).

Trankplots are an alternative for [`traceplot`](@ref)s which perform well at reveal convergence issues irrespective of the number of iterations per chain.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = trankplot(chains)
fig
```

## Attributes

### `color`

Specifies the `color`s to be used for coloring the rank trace of each chain.

Defaults to Makie's [`wong_colors`](https://docs.makie.org/dev/explanations/colors#Colormaps) palette and automatically switches to [`colormap = :viridis`](https://docs.makie.org/dev/explanations/colors#Colormaps) for more than seven chains.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = trankplot(chains; color = first(Makie.to_colormap(:tab20), 3))
fig
```

### `colormap`

Specifies the `colormap` to be used for coloring the rank trace of each chain.

Defaults to `:viridis`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 8), [:A, :B])
fig = trankplot(chains; colormap = :plasma)
fig
```

### `linewidth`

Controls the `linewidth` of each rank trace.

Defaults to `1.5`.

### `alpha`

Controls the opacity of each rank trace.

Defaults to `0.8`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 8), [:A, :B])
fig = trankplot(chains; linewidth = 1.0, alpha = 1.0)
fig
```
