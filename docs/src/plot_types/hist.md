```@meta
CurrentModule = ChainsMakie
```

# `hist`

Plotting a histogram of `Chains` creates a histogram for the samples in each chain.

Its role in evaluating MCMC samples is similar to that of [`density`](@ref).

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = hist(chains)
fig
```

## Attributes

### `color`

Specifies the `color`s to be used for coloring the histogram of each chain.

Defaults to Makie's [`wong_colors`](https://docs.makie.org/dev/explanations/colors#Colormaps) palette and automatically switches to [`colormap = :viridis`](https://docs.makie.org/dev/explanations/colors#Colormaps) for more than seven chains.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = hist(chains; color = first(Makie.to_colormap(:tab20), 2))
fig
```

### `colormap`

Specifies the `colormap` to be used for coloring the histogram of each chain.

Defaults to `:viridis`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 8), [:A, :B])
fig = hist(chains; colormap = :plasma)
fig
```

### `bins`

Controls the number of bins used for each histogram.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = hist(chains; bins = 30)
fig
```

### `linewidth`

Controls the `linewidth` of the contour around each histogram.

### `alpha`

Controls the opacity of each histogram.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = hist(chains; linewidth = 0.0, alpha = 0.8)
fig
```
