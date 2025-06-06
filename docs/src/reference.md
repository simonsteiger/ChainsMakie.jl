```@meta
CurrentModule = ChainsMakie
```

# Reference

## `autocorplot`

Plots the autocorrelations of the first 20 samples per chain.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

autocorplot(chains)
```

It is possible to plot a subset of the parameters by passing their names as the second argument, i.e., `autocorplot(chains, [:A, :B])`.

### Attributes

#### `lags`

Controls at which lags the autocorrelation will be calculated.

Defaults to `0:20`.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = autocorplot(chains; lags = 0:5:100)

fig
```

#### `color`

Controls which `color`s will be used to color the samples from each chain.

Defaults to Makie's `wong_colors` palette and automatically switches to `colormap = :viridis` for more than seven chains.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = autocorplot(chains; color = first(Makie.to_colormap(:tab20), 3))

fig
```

#### `colormap`

Controls which `colormap` will be used to color the samples from each chain.

Defaults to the `:viridis` palette.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = autocorplot(chains; colormap = :plasma)

fig
```

#### `linewidth`

Controls the `linewidth` of the autocorrelation plot of each chain.

Defaults to the `1.5`.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 5, 3), [:A, :B, :C, :D, :E])

fig = autocorplot(chains; linewidth = 1.0)

fig
```

#### `alpha`

Controls the opacity of the autocorrelation plot of each chain.

Defaults to `1.0`.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 5, 3), [:A, :B, :C, :D, :E])

fig = autocorplot(chains; alpha = 0.8)

fig
```

## `barplot`

This function is still WIP and might change to horizontal lines instead of bars.

### Attributes

WIP.

## `density`

Plots `density` plots for each individual chain.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = density(chains)

fig
```

It is possible to plot a subset of the parameters by passing their names as the second argument, i.e., `density(chains, [:A, :B])`.

### Attributes

#### `color`

Controls which `color`s will be used to color the `density` plot for each chain.

Defaults to Makie's `wong_colors` palette and automatically switches to `colormap = :viridis` for more than seven chains.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = density(chains; color = first(Makie.to_colormap(:tab20), 3))

fig
```

#### `colormap`

Controls which `colormap` will be used to color the `density` plot for each chain.

Defaults to the `:viridis` palette.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 8), [:A, :B, :C])

fig = density(chains; colormap = :plasma)

fig
```

#### `strokewidth`

Controls the `strokewidth` of the density plot's contour.

Defaults to `1.0`.

#### `alpha`

Controls the opacity of the density plot.

Defaults to `0.4`.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = density(chains; strokewidth = 0.0, alpha = 0.8)

fig
```

## `forestplot`

Plots a summary of the samples in `chains` for each parameter by showing a `point_summary` and the central interval containing a specified `coverage`.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig, ax, plt = forestplot(chains)

fig
```

### Attributes

#### `coverage`

You can choose which coverage intervals should be plotted by passing a custom vector of values between 0 and 1.
The proportion outside the `coverage` will be distributed equally on the lower and upper tails of the summarised distribution.

Defaults to `[0.95, 0.90]`.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig, ax, plt = forestplot(chains; coverage = [0.99, 0.95, 0.89])

fig
```

#### `point_summary`

Controls which function will be used to calculate the `point_summary`.
Any function can be used so long as it returns a single `Real` number when applied to a vector `Real`s.

Defaults to `median`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig, ax, plt = forestplot(chains; point_summary = mean)

fig
```

#### `colormap`

Specifies the `colormap` to be used for coloring the different quantiles.

Defaults to `:viridis`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig, ax, plt = forestplot(chains; point_summary = mean)

fig
```

#### `min_width`

Controls the `linewidth` of the narrowest interval.

Defaults to `4`.

#### `max_width`

Controls the `linewidth` of the widest interval.

Defaults to `8`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

coverage = [0.99, 0.95, 0.89, 0.8]

fig, ax, plt = forestplot(chains; coverage, min_width = 3, max_width = 12)

fig
```

## `hist`

Plots the histogram of the samples for each chain and parameter.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = hist(chains)

fig
```

### Attributes

#### `color`

Specifies the `color`s to be used for coloring the histogram of each chain.

Defaults to Makie's `wong_colors` palette and automatically switches to `colormap = :viridis` for more than seven chains.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = hist(chains; color = first(Makie.to_colormap(:tab20), 3))

fig
```

#### `colormap`

Specifies the `colormap` to be used for coloring the histogram of each chain.

Defaults to `:viridis`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 8), [:A, :B, :C])

fig = hist(chains; colormap = :plasma)

fig
```

#### `bins`

Controls the number of bins used for each histogram.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = hist(chains; bins = 30)

fig
```

#### `linewidth`

Controls the `linewidth` of the contour around each histogram.

#### `alpha`

Controls the opacity of each histogram.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = hist(chains; linewidth = 0.0, alpha = 0.8)

fig
```

## `meanplot`

Plots the running average of the samples for each chain and parameter.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = meanplot(chains)

fig
```

### Attributes

#### `color`

Specifies the `color`s to be used for coloring the running average of each chain.

Defaults to Makie's `wong_colors` palette and automatically switches to `colormap = :viridis` for more than seven chains.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = meanplot(chains; color = first(Makie.to_colormap(:tab20), 3))

fig
```

#### `colormap`

Specifies the `colormap` to be used for coloring the running average of each chain.

Defaults to `:viridis`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 8), [:A, :B, :C])

fig = meanplot(chains; colormap = :plasma)

fig
```

#### `linewidth`

Controls the `linewidth` of each line.

#### `alpha`

Controls the opacity of each line.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = meanplot(chains; linewidth = 0.0, alpha = 0.8)

fig
```

## `ridgeline`

Plots the densities of the samples for each parameter in a single axis by stacking them vertically.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig, ax, plt = ridgeline(chains)

fig
```

### Attributes

#### `color`

Controls the `color` of each density plot.

Defaults to the first color in Makie's `wong_colors` palette.

#### `strokewidth`

Controls the `strokewidth` of the density plot's contour.

Defaults to `1.0`.

#### `strokecolor`

Controls the `strokecolor` of the contour around each density plot.

Defaults to the first color in Makie's `wong_colors` palette.

#### `alpha`

Controls the opacity of each density plot.

Defaults to `0.4`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig, ax, plt = ridgeline(chains; color = :orange, strokecolor = :orange, alpha = 0.6)

fig
```

## `traceplot`

Plots the sampled values per iteration for each chain and parameter.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = traceplot(chains)

fig
```

### Attributes

#### `color`

Specifies the `color`s to be used for coloring the traceplot of each chain.

Defaults to Makie's `wong_colors` palette and automatically switches to `colormap = :viridis` for more than seven chains.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = traceplot(chains; color = first(Makie.to_colormap(:tab20), 3))

fig
```

#### `colormap`

Specifies the `colormap` to be used for coloring the traceplot of each chain.

Defaults to `:viridis`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 8), [:A, :B, :C])

fig = traceplot(chains; colormap = :plasma)

fig
```

#### `linewidth`

Controls the `linewidth` of the traceplot.

Defaults to `1.5`.

#### `alpha`

Controls the opacity of the traceplot.

Defaults to `0.8`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 8), [:A, :B, :C])

fig = trankplot(chains; linewidth = 1.0, alpha = 1.0)

fig
```

## `trankplot`

Plots the binned ranks of sampled values for each chain and parameter.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = trankplot(chains)

fig
```

### Attributes

#### `color`

Specifies the `color`s to be used for coloring the trankplot of each chain.

Defaults to Makie's `wong_colors` palette and automatically switches to `colormap = :viridis` for more than seven chains.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

fig = trankplot(chains; color = first(Makie.to_colormap(:tab20), 3))

fig
```

#### `colormap`

Specifies the `colormap` to be used for coloring the trankplot of each chain.

Defaults to `:viridis`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 8), [:A, :B, :C])

fig = trankplot(chains; colormap = :plasma)

fig
```

#### `linewidth`

Controls the `linewidth` of the trankplot.

Defaults to `1.5`.

#### `alpha`

Controls the opacity of the trankplot.

Defaults to `0.8`.

```@example
using ChainsMakie, CairoMakie, StatsBase
import MCMCChains: Chains

chains = Chains(randn(300, 3, 8), [:A, :B, :C])

fig = trankplot(chains; linewidth = 1.0, alpha = 1.0)

fig
```

