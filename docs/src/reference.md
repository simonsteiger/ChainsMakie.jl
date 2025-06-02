```@meta
CurrentModule = ChainsMakie
```

# Reference

## `autocorplot`

### Attributes

#### `lags`

You can pass a custom range of lags at which the autocorrelation should be calculated:

```@example
using ChainsMakie, CairoMakie, MCMCChains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

autocorplot(chains; lags = 0:5:100)
```

## `barplot`

### Attributes


## `density`

### Attributes


## `forestplot`

### Attributes


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

