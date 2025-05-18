module ChainsMakie

using Makie, MCMCChains, StatsBase

export density, hist, barplot
export traceplot, traceplot!
export trankplot, trankplot!
export plot

public chainsdensity, chainsdensity!
public chainshist, chainshist!
public chainsbarplot, chainsbarplot!

include("utils.jl")
include("density.jl")
include("barplot.jl")
include("hist.jl")
include("traceplot.jl")
include("trankplot.jl")
include("plot.jl")

end
