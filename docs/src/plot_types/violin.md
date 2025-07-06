```@meta
CurrentModule = ChainsMakie
```

# `violin`

Plot a violin plot of all samples in each of the chains.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 2, 4), [:A, :B])
fig = violin(chains)
fig
```

It is possible to plot a subset of the parameters by passing their names as the second argument:

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains
chains = Chains(randn(300, 3, 4), [:A, :B, :C])
violin(chains, [:A, :B])
```

## Attributes

This method shares all the attributes of `Violin`, and has a single additional attribute `link_x`.

### `link_x`

Apply the same x axis limits and ticks across subplots, and hide x axis decorations on all subplots except the bottom one.
Only applies to `:horizontal` orientation.

Defaults to `false`.

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains
chains = Chains(randn(300, 3, 4), [:A, :B, :C])
violin(chains, [:A, :B]; orientation = :horizontal, link_x = true)
```
