module ChainsMakie

using Makie, MCMCChains

export density, density!
export traceplot, traceplot!

include("density.jl")
include("traceplot.jl")

end
