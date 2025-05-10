module ChainsMakie

using Makie, MCMCChains, StatsBase

export density, chainsdensity, chainsdensity!
export traceplot, traceplot!
export trankplot, trankplot!
export plot

include("density.jl")
include("traceplot.jl")
include("trankplot.jl")
include("plot.jl")

end
