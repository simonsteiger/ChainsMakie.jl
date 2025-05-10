function testchains(; n = 300, p = 5, c = 4)
    parameters = [:A, :B, :C, :D, :E]
    return Chains(randn(Xoshiro(42), n, p, c), first(parameters, p))
end

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

reftest("single trankplot") do
    chns = testchains()
    fig, ax, plt = trankplot(chns[:, :B, :])
    return fig
end

reftest("two trankplots") do
    chns = testchains()
    fig = trankplot(chns, ["A", "B"])
    return fig
end

reftest("single density") do
    chns = testchains()
    fig, ax, plt = chainsdensity(chns[:, :B, :])
    return fig
end

reftest("two densities") do
    chns = testchains()
    fig = density(chns, ["A", "B"])
    return fig
end

reftest("single hist") do
    chns = testchains()
    fig, ax, plt = chainshist(chns[:, :B, :])
    return fig
end

reftest("two hists") do
    chns = testchains()
    fig = hist(chns, ["A", "B"])
    return fig
end

reftest("plot method") do
    chns = testchains(p = 2)
    fig = plot(chns)
    return fig
end
