using ChainsMakie, CairoMakie, Distributions

green = colorant"#389826"
purple = colorant"#9658B2"
red = colorant"#CA3C33"

colors = [
    [red, purple, green, green],
    [green, purple, red, red],
    [green, red, purple, purple],
]

X = [rand(Normal(3.5, 0.75), 100) for _ in 1:4]
Xt = reduce(hcat, X)

fig = Figure(backgroundcolor = :transparent)
ax1 = PolarAxis(fig[1, 2:3], backgroundcolor = :transparent)
ax2 = PolarAxis(fig[2, 1:2], backgroundcolor = :transparent)
ax3 = PolarAxis(fig[2, 3:4], backgroundcolor = :transparent)

for (ax, color) in zip([ax1, ax2, ax3], colors)
    traceplot!(ax, Xt; linewidth=0.75, color)
    hidedecorations!(ax)
    ax.spinecolor = last(color)
    ax.rlimits = (0, 4.1)
    hidespines!(ax)
end

save("src/assets/logo_test.svg", fig)
