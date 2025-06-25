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

reftest("forestplot median") do
    chns = testchains()
    fig, ax, plt = forestplot(chns, [:A, :B, :C, :D])
    return fig
end

reftest("two autocorplots") do
    chns = testchains()
    fig = autocorplot(chns, ["A", "B"])
    return fig
end

reftest("autocorplots lags") do
    chns = testchains()
    sub_chns = chns[:, [:A, :B], :]
    fig = autocorplot(sub_chns; lags = 0:5:100)
    return fig
end

reftest("two meanplots") do
    chns = testchains()
    fig = meanplot(chns, ["A", "B"])
    return fig
end

reftest("violin") do
    chns = testchains()
    fig = violin(chns, ["A", "B"])
    return fig
end

reftest("plot vanilla") do
    chns = testchains(continuous_samples(p = 2))
    fig = plot(chns)
    return fig
end

#=
reftest("plot vanilla linkx") do
    chns = testchains(continuous_samples(p = 2))
    fig = plot(chns; link_x = true)
    return fig
end
=#

reftest("plot custom colors") do
    chns = testchains(continuous_samples(p = 2))
    fig = plot(chns; color = first(Makie.to_colormap(:tab20), 10))
    return fig
end

reftest("plot two banks") do
    chns = testchains(continuous_samples(p = 2, c = 6))
    fig = plot(chns)
    return fig
end

reftest("plot > 7 chains") do
    chns = testchains(continuous_samples(p = 2, c = 8))
    fig = plot(chns)
    return fig
end

reftest("plot mixed densities") do
    a = Real[discrete_samples() continuous_samples(p = 1)]
    chns = testchains(a)
    fig = plot(chns)
    return fig
end

reftest("plot custom funs") do
    chns = testchains(continuous_samples(p = 2, c = 6))
    fig = plot(chns, trankplot!, chainshist!, meanplot!)
    return fig
end

reftest("plot custom funs and colors") do
    chns = testchains(continuous_samples(p = 2, c = 6))
    color = first(Makie.to_colormap(:tab20), 10)
    funs = [trankplot!, chainshist!, meanplot!]
    fig = plot(chns, funs...; color)
    return fig
end
