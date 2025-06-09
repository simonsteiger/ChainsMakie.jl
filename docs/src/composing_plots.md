```@meta
CurrentModule = ChainsMakie
```

# Composing plots

ChainsMakie allows you to compose custom summary plots by passing two or more of the plotting functions exported by ChainsMakie to `plot`.

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains
chains = Chains(randn(300, 3, 4), [:A, :B, :C])
plot(chains, trankplot!, chainshist!, meanplot!)
```

All functions passed must be mutating versions of the plotting functions, i.e., they must end in `!`.
In addition, for `density` and `hist` it is currently required to pass their specific `chains`-prefixed recipes.

For a list of the supported functions, see [`plot`](@ref).
