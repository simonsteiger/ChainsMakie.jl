module ChainsMakie

using Makie, MCMCChains, Compat
using StatsBase, Statistics

export traceplot, traceplot!
export trankplot, trankplot!
export ridgeline, ridgeline!
export forestplot, forestplot!
export autocorplot, autocorplot!
export meanplot, meanplot!

# Exports below are type piracy because I don't own Chains?
export density, hist, barplot, violin
export plot

@compat public chainsdensity, chainsdensity!
@compat public chainshist, chainshist!
@compat public chainsbarplot, chainsbarplot!
@compat public chainsviolin, chainsviolin!

include("utils.jl")
include("density.jl")
include("barplot.jl")
include("hist.jl")
include("traceplot.jl")
include("trankplot.jl")
include("ridgeline.jl")
include("forestplot.jl")
include("autocorplot.jl")
include("meanplot.jl")
include("violin.jl")
include("plot.jl")

end
