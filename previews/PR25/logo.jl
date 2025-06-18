using ChainsMakie, CairoMakie, Distributions

green = colorant"#389826"
purple = colorant"#9658B2"
red = colorant"#CA3C33"

colors = [
    [red, purple, green, green],
    [green, purple, red, red],
    [green, red, purple, purple],
]

X = rand(MvNormal(ones(4) .+ 2.5, ones(4) .- 0.25), 100)
Xt = permutedims(X)

fig = Figure()
ax1 = PolarAxis(fig[1, 2:3])
ax2 = PolarAxis(fig[2, 1:2])
ax3 = PolarAxis(fig[2, 3:4])

for (ax, color) in zip([ax1, ax2, ax3], colors)
    traceplot!(ax, Xt; linewidth=0.75, color)
    hidedecorations!(ax)
    ax.spinecolor = last(color)
    ax.rlimits = (0, 4.1)
    hidespines!(ax)
end

save("src/assets/logo.svg", fig)
