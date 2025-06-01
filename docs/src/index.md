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

[MCMC chains](https://turinglang.org/MCMCChains.jl/stable/) are common objects in probabilistic programming languages such as [Turing.jl](https://turinglang.org/).
Inspecting the MCMC chains visually is a key part of the workflow, and ChainsMakie.jl provides a set of tools to simplify this task.

```@example
using ChainsMakie, CairoMakie, MCMCChains

chains = Chains(randn(300, 3, 3), [:A, :B, :C])

plot(chains)
```

````@raw html
</div>
````
