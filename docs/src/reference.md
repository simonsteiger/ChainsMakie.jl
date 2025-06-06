```@meta
CurrentModule = ChainsMakie
```

# Reference

## `autocorplot`

### Attributes

#### `lags`

You can pass a custom range of lags at which the autocorrelation should be calculated:

```@example
using ChainsMakie, CairoMakie 
import MCMCChains: Chains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

autocorplot(chains; lags = 0:5:100)
```

## `barplot`

### Attributes


## `density`

### Attributes


## `forestplot`

### Attributes

#### `coverage`

You can choose which coverage intervals should be plotted by passing a custom vector of values between 0 and 1.
The proportion outside the `coverage` will be distributed equally on the lower and upper tails of the summarised distribution.

```@example
chains = Chains(randn(300, 3, 3), [:A, :B, :C])
fig, ax, plt = forestplot(chains; coverage = [0.99, 0.95, 0.89])
```

## `hist`

### Attributes


## `meanplot`

### Attributes


## `plot`

### Attributes


## `ridgeline`

### Attributes


## `traceplot`

### Attributes


## `trankplot`

### Attributes

