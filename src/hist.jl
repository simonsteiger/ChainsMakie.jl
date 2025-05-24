@recipe(ChainsHist) do scene
    Attributes(
        color = Makie.wong_colors(),
        bins = 15,
        alpha = 0.4,
        linewidth = 1.5,
    )
end

function Makie.plot!(ch::ChainsHist{<:Tuple{<:AbstractMatrix}})
    mat = ch[1]

    if size(mat[], 2) > length(ch.color[])
        throw(error("Specify at least as many colors as there are chains."))
    end
    
    for (i, ys) in enumerate(eachcol(to_value(mat)))
        hist!(ch, ys; color = (ch.color[][i], ch.alpha[]), bins = ch.bins[])
        stephist!(ch, ys; bins = ch.bins[], color = ch.color[][i], linewidth = ch.linewidth[])
    end
    
    return ch
end

# TODO adjust decoration hiding based on loop
function Makie.hist(chains::Chains, parameters; hidey=true, kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1])
        hidex = i < length(parameters)
        _axisdecorations!(ax, hidex, "Parameter estimate", hidey, parameter) # FIXME don't do this hidex hidey thing
        chainshist!(chains[:, parameter, :]; kwargs...)
    end
    return fig
end
