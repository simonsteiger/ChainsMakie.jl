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

This method shares all the attributes of `Violin`.
