@recipe(ChainsHist) do scene
    Attributes(
        color = Makie.wong_colors(),
        bins = 15,
    )
end

function Makie.plot!(ch::ChainsHist{<:Tuple{<:AbstractMatrix}})
    mat = ch[1]
    # FIXME this currently breaks for > 7 chains! Error and tell user to specify more colors
    for (i, ys) in enumerate(eachcol(to_value(mat)))
        hist!(ch, ys; color = (to_value(ch.color)[i], 0.8))
    end
    return ch
end

# TODO adjust decoration hiding based on loop
function Makie.hist(chains::Chains, parameters; hidey=true, kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter)
        chainshist!(chains[:, parameter, :]; kwargs...)
    end
    return fig
end
