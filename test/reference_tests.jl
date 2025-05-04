testchains() = Chains(randn(Xoshiro(42), 300, 5, 4), [:A, :B, :C, :D, :E])

reftest("single traceplot") do
    chns = testchains()
    fig, ax, plt = traceplot(chns[:, :B, :])
    return fig
end

reftest("two traceplots") do
    chns = testchains()
    fig = traceplot(chns, ["A", "B"])
    return fig
end

#=
reftest("plot method") do
    chns = testchains()
    fig = plot(chns)
    return fig
end
=#
