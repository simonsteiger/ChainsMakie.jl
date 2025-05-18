module ChainsMakie

using Makie, MCMCChains, StatsBase, Compat

export density, hist, barplot
export traceplot, traceplot!
export trankplot, trankplot!
export ridgeline, ridgeline!
export plot

@compat public chainsdensity, chainsdensity!
@compat public chainshist, chainshist!
@compat public chainsbarplot, chainsbarplot!

include("utils.jl")
include("density.jl")
include("barplot.jl")
include("hist.jl")
include("traceplot.jl")
include("trankplot.jl")
include("ridgeline.jl")
include("plot.jl")

end
