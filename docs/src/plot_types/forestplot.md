```@meta
CurrentModule = ChainsMakie
```

# `forestplot`

A [`forestplot`](@ref) of `Chains` displays point summaries of all samples per parameter with horizontal lines representing one or more credible intervals.

Forest plots allow for easy comparison of posterior distributions across multiple parameters. 
This, forest plots are better suited for reporting and interpretation than diagnosing issues in MCMC sampling because they collapse samples across chains.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
forestplot(chains)
```

It is possible to plot a subset of the parameters by passing their names as the second argument:

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains
chains = Chains(randn(300, 3, 4), [:A, :B, :C])
forestplot(chains, [:A, :B])
```

## Attributes

### `ci`

You can choose which credible intervals should be plotted by passing a custom vector of values between 0 and 1.
The proportion outside the `ci` will be distributed equally on the lower and upper tails of the summarised distribution.

Defaults to `[0.95, 0.90]`.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
forestplot(chains; ci = [0.99, 0.95, 0.89])
```

### `point_summary`

Controls which function will be used to calculate the `point_summary`.
Any function can be used so long as it returns a single `Real` number when applied to a vector `Real`s.

Defaults to `median`.

```@example
using ChainsMakie, CairoMakie
import StatsBase: mean
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
forestplot(chains; point_summary = mean)
```

### `colormap`

Specifies the `colormap` to be used for coloring the different quantiles.

Defaults to [`:viridis`](https://docs.makie.org/dev/explanations/colors#Colormaps).

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
forestplot(chains; colormap = :plasma)
```

### `min_width`

Controls the `linewidth` of the narrowest interval.

Defaults to `4`.

### `max_width`

Controls the `linewidth` of the widest interval.

Defaults to `8`.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 5, 4), [:A, :B, :C, :D, :E])
ci = [0.99, 0.95, 0.89, 0.8]
forestplot(chains; ci, min_width = 3, max_width = 12)
```
