reftest("two traceplots") do
    chns = testchains()
    fig = traceplot(chns, ["A", "B"])
    return fig
end

reftest("two trankplots") do
    chns = testchains()
    fig = trankplot(chns, ["A", "B"])
    return fig
end

reftest("two densities") do
    chns = testchains()
    fig = density(chns, ["A", "B"])
    return fig
end

reftest("two hists") do
    chns = testchains()
    fig = hist(chns, ["A", "B"])
    return fig
end

reftest("ridgeline") do
    chns = testchains()
    fig, ax, plt = ridgeline(chns, ["A", "B"])
    return fig
end

reftest("ridgeline symbols 4 pars") do
    chns = testchains()
    fig, ax, plt = ridgeline(chns, [:A, :B, :C, :D])
    return fig
end

reftest("forestplot median") do
    chns = testchains()
    fig, ax, plt = forestplot(chns, [:A, :B, :C])
    return fig
end

reftest("forestplot mean") do
    chns = testchains()
    fig, ax, plt = forestplot(chns, [:A, :B, :C], point_summary = mean)
    return fig
end

reftest("plot method") do
    chns = testchains(continuous_samples(p = 2))
    fig = plot(chns)
    return fig
end

reftest("plot method two banks") do
    chns = testchains(continuous_samples(p = 2, c = 6))
    fig = plot(chns)
    return fig
end

reftest("plot method > 7 chains") do
    chns = testchains(continuous_samples(p = 2, c = 8))
    fig = plot(chns)
    return fig
end

reftest("plot method custom figsize") do
    chns = testchains(continuous_samples(p = 2))
    fig = Figure(size = (600, 600))
    fig = plot(chns; figure = fig)
    return fig
end

reftest("plot method mixed densities") do
    a = Real[discrete_samples() continuous_samples(p = 1)]
    chns = testchains(a)
    fig = plot(chns)
    return fig
end
