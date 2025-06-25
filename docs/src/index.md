````@raw html
---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: ChainsMakie.jl
  text: 
  tagline: MCMC Chains plots for Makie.jl
  image:
    src: /logo.svg
    alt: ChainsMakie
  actions:
    - theme: brand
      text: Reference
      link: /reference
    - theme: alt
      text: View on Github
      link: https://github.com/simonsteiger/ChainsMakie.jl
    - theme: alt
      text: API Reference
      link: /api
---


<p style="margin-bottom:2cm"></p>

<div class="vp-doc" style="width:80%; margin:auto">
````

# What is ChainsMakie.jl?

ChainsMakie provides a set of tools to simplify the visualization of [MCMC chains](https://turinglang.org/MCMCChains.jl/stable/).
MCMC chains are objects that contain the results of sampling algorithms used for Bayesian inference in probabilistic programming languages such as [Turing.jl](https://turinglang.org/).

```@example
using ChainsMakie, CairoMakie
import MCMCChains: Chains

chains = Chains(randn(300, 3, 4), [:A, :B, :C])

julia_quartet = [colorant"#4e63ae", colorant"#208921", colorant"#cc3333", colorant"#b352cc"]
plot(chains; color = julia_quartet, link_x = true)
```

````@raw html
</div>
````
