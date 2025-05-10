module ChainsMakie

using Makie, MCMCChains, StatsBase

export density, chainsdensity, chainsdensity!
export hist, chainshist, chainshist!
export traceplot, traceplot!
export trankplot, trankplot!
export plot

include("utils.jl")
include("density.jl")
include("hist.jl")
include("traceplot.jl")
include("trankplot.jl")
include("plot.jl")

end
