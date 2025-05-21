@recipe(ForestPlot) do scene
    Attributes(
        quantiles = [0.99, 0.95, 0.9, 0.8, 0.5],
        colormap = :viridis, # TODO allow passing a custom colormap and not just a symbol
        point_summary = median,
        min_width = 0.05,
        max_width = 0.15,
    )
end

function Makie.plot!(fp::ForestPlot{<:Tuple{<:AbstractVector{<:AbstractVector}}})
    samples = fp[1]

    qs = [[quantile.(Ref(samples_i), [1 - lim, lim]) for samples_i in samples[]]
          for lim in sort(fp.quantiles[], rev = true)]

    colors = get_colors(length(fp.quantiles[]); colormap = fp.colormap[], threshold = 0)
    
    widths = range(fp.min_width[], fp.max_width[], length = length(colors))

    for (q, color, width) in zip(qs, colors, widths)
        barplot!(fp, eachindex(samples[]), sdim(1)(q); 
            fillto = sdim(2)(q), color = color, direction = :x, width = width)
    end

    points = fp.point_summary[].(samples[])
    if !(points isa Vector{Float64})
        throw(error("Calling `point_summary` on a Vector must return a Float64."))
    end

    scatter!(fp, points, eachindex(samples[]); marker = :diamond, markersize = 24, 
        color = to_colormap(fp.colormap[])[end], strokecolor = :black, strokewidth = 1.5)

    return fp
end

function forestplot(chn::Chains, parameters; kwargs...)
    samples = [vec(chn[:, parameter, :]) for parameter in parameters]

    fig = Figure()
    ax = Axis(fig[1, 1])
    ax.yticks = (eachindex(parameters), reverse(string.(parameters)))
    ax.xlabel = "Parameter estimate"
    plt = forestplot!(samples; kwargs...)
    
    # Legend using the quantiles entry from kwargs

    return fig, ax, plt
end
