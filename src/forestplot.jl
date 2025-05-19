@recipe(ForestPlot) do scene
    Attributes(
        quantiles = [0.99, 0.95, 0.9, 0.8],
        color = :slategray,
    )
end

function Makie.plot!(fp::ForestPlot{<:Tuple{<:AbstractVector{<:AbstractVector}}})
    samples = fp[1]
    
    for (i, ys) in enumerate(samples[])
        qs = [quantile(ys, [1 - lim, lim]) for lim in sort(quantiles[], rev = true)]
        for q in qs
            barplot!(i, q[1]; fillto = q[2], color = (fp.color[], 0.1), direction = :x)
        end
    end
    
    return fp
end

function forestplot(chn::Chains, parameters; figure = nothing, kwargs...)
    samples = [vec(chn[:, parameter, :]) for parameter in parameters]

    if !(figure isa Figure)
        figure = Figure(size = (400, 150 * length(parameters)))
    end

    ax = Axis(figure[1, 1])
    ax.yticks = (eachindex(parameters) ./ 2, reverse(string.(parameters)))
    plt = forestplot!(samples; kwargs...)

    return figure, ax, plt
end
