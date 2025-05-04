module ChainsMakie

using Makie, MCMCChains

export density, chainsdensity, chainsdensity!
export traceplot, traceplot!
export plot

include("density.jl")
include("traceplot.jl")
include("plot.jl")

end
