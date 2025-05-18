# Ridgeline should only require a ... array of arrays? Then we have a special method for chains
@recipe(RidgeLine) do scene
    Attributes(
        color = Makie.wong_colors()[1],
        strokewidth = 1, 
        strokecolor = Makie.wong_colors()[1],
        alpha = 0.4,
    )
end

function Makie.plot!(rl::RidgeLine{<:Tuple{<:AbstractVector{<:AbstractVector}}})
    vectors = rl[1]
    for (i, vector) in enumerate(vectors[])
        density!(rl, vector, offset = i/2, color = (rl.color[], rl.alpha[]), 
                 strokecolor = rl.strokecolor[], strokewidth = rl.strokewidth)
    end
    return rl
end

function ridgeline(chn::Chains, parameters; figure = nothing, kwargs...)
    samples = [vec(chn[:, parameter, :]) for parameter in parameters]

    if !(figure isa Figure)
        figure = Figure(size = (400, 150 * length(parameters)))
    end

    ax = Axis(figure[1, 1])
    ax.yticks = (eachindex(parameters) ./ 2, reverse(string.(parameters)))
    plt = ridgeline!(samples; kwargs...)

    return figure, ax, plt
end

# TODO ridgeline!(chn, parameters) with and without passing axis
