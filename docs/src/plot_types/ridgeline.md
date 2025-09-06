```@meta
CurrentModule = ChainsMakie
```

# `ridgeline`

A [`ridgeline`](@ref) plot shows the densities of the samples for each parameter in a single axis by stacking them vertically.

Similar to the [`forestplot`](@ref), this visualization does not contain information about each individual chain.
Instead, it can provide a more concise overview of parameter distributions after the computational faithfulness of MCMC sampling has been validated.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig, ax, plt = ridgeline(chains)
fig
```

It is possible to plot a subset of the parameters by passing their names as the second argument:

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains
chains = Chains(randn(300, 3, 4), [:A, :B, :C])
ridgeline(chains, [:A, :B])
```

## Attributes

### `color`

Controls the `color` of each density plot.

Defaults to the first color in Makie's `wong_colors` palette.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
ridgeline(chains; color = :orange)
```

### `strokewidth`

Controls the `strokewidth` of the density plot's contour.

Defaults to `1.0`.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
ridgeline(chains; strokewidth = 2.0)
```

### `strokecolor`

Controls the `strokecolor` of the contour around each density plot.

Defaults to the first color in Makie's [`wong_colors`](https://docs.makie.org/dev/explanations/colors#Colormaps) palette.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
ridgeline(chains; strokecolor = :black)
```

### `alpha`

Controls the opacity of each density plot.

Defaults to `0.4`.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
ridgeline(chains; alpha = 0.6)
```
