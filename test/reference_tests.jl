function continuous_samples(; n = 300, p = 4, c = 4)
    return randn(Xoshiro(42), n, p, c)
end

function discrete_samples(; n = 300, p = 1, c = 4)
    return reshape(repeat(1:4, n ÷ 4 * c), (n, p, c))
end

function testchains(a = continuous_samples())
    p = size(a, 2)
    parameters = [:A, :B, :C, :D, :E]
    @assert p < length(parameters)
    return Chains(a, first(parameters, p))
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
    chns = testchains(continuous_samples(p = 2))
    fig = plot(chns)
    return fig
end

reftest("plot method mixed densities") do
    a = Real[discrete_samples() continuous_samples(p = 1)]
    chns = testchains(a)
    fig = plot(chns)
    return fig
end
