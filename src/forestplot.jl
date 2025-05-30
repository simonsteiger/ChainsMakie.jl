const default_coverage = [0.95, 0.90]

@recipe(ForestPlot) do scene
    Attributes(
        coverage = default_coverage,
        colormap = :viridis, # TODO allow passing a custom colormap and not just a symbol
        point_summary = median,
        min_width = 4,
        max_width = 8,
    )
end

coverage_to_quantiles(x) = 1 - (1 - x) / 2, (1 - x) / 2
forest_colors(n; kwargs...) = first(get_colors(n + 1; threshold = 0, kwargs...), n)

function Makie.plot!(fp::ForestPlot{<:Tuple{<:AbstractVector{<:AbstractVector}}})
    samples = fp[1]

    for coverage in fp.coverage[]
        0 < coverage < 1 || error("Coverage must be between 0 and 1, got $coverage.")
    end
    
    sorted_qs = map(coverage_to_quantiles, sort(fp.coverage[], rev = true))

    qs = [[quantile.(Ref(s_i), qs_i) for s_i in samples[]] for qs_i in sorted_qs]

    colors = forest_colors(length(fp.coverage[]); colormap = fp.colormap[])
    
    linewidths = range(fp.min_width[], fp.max_width[], length = length(colors))

    for (q, color, linewidth) in zip(qs, colors, linewidths)
        for (i, xmin, xmax) in zip(eachindex(samples[]), sdim(1)(q), sdim(2)(q))
            lines!(fp, [xmin, xmax], fill(i, 2); color, linewidth)
        end
    end

    points = fp.point_summary[].(samples[])
    if !(points isa Vector{Float64})
        throw(error("Calling `point_summary` on a Vector must return a Float64."))
    end

    scatter!(fp, points, eachindex(samples[]); marker = :diamond, markersize = 18, 
        color = last(to_colormap(fp.colormap[])), strokecolor = :black, strokewidth = 1.5)

    return fp
end

function forestplot(chains::Chains, parameters; figure = nothing, kwargs...)
    samples = [vec(chains[:, parameter, :]) for parameter in parameters]

    if !(figure isa Figure)
        figure = Figure()
    end

    ax = Axis(figure[1, 1])
    ax.yticks = (eachindex(parameters), reverse(string.(parameters)))
    ax.xlabel = "Parameter estimate"
    plt = forestplot!(samples; kwargs...)
    
    label_values = haskey(kwargs, :coverage) ? kwargs[:coverage] : default_coverage
    
    labels = @. string(round(Int, label_values * 100)) * "%"
    colors = forest_colors(length(labels))
    elems = [PolyElement(; color) for color in colors]
    Legend(figure[1, 2], elems, labels, "Quantiles", tellheight = false)

    return figure, ax, plt
end

forestplot(chains::Chains; kwargs...) = forestplot(chains, names(chains); kwargs...)
