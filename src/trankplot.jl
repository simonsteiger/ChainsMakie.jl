@recipe(TrankPlot) do scene
    Attributes(
        color = :default,
        colormap = :default,
        linewidth = 1.5,
        bins = 20,
        alpha = 1.0,
    )
end

function Makie.plot!(tp::TrankPlot{<:Tuple{<:AbstractMatrix}})
    mat = tp[1]
    color = get_colors(size(mat[], 2); color = tp.color[], colormap = tp.colormap[])

    binmat = lift((m, bins) -> bin_chain(m; bins), mat, tp.bins)
    
    xs = lift(mat, tp.bins) do m, length
        r = range(1, size(m, 1); length)
        padx!(r, centers(r))
    end

    for (i, col) in enumerate(eachcol(to_value(binmat))) # FIXME interactivity?
        ys = pady!(collect(col))
        stairs!(tp, xs, ys; step = :center, color = (color[i], tp.alpha[]))
    end
    
    return tp
end

function trankplot(chains::Chains, parameters; figure = nothing, kwargs...)
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end

    for (i, parameter) in enumerate(parameters)
        ax = Axis(figure[i, 1], ylabel = string(parameter))
        trankplot!(chains[:, parameter, :]; kwargs...)
    
        hideydecorations!(ax; label=false)
        if i < length(parameters)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Iteration"
        end    
    end

    color = get_colors(size(chains[:, parameters, :], 3); kwargs...)
    chainslegend(figure, chains[:, parameters, :], color)
    
    return figure
end

trankplot(chains::Chains; kwargs...) = trankplot(chains, names(chains); kwargs...)

function bin_chain(mat::AbstractMatrix; bins = 20)
    ranks = denserank(mat)
    rank_range = range(extrema(ranks)..., length = bins)
    out = zeros(Int, bins - 1, size(ranks, 2))
    for (i, col) in enumerate(eachcol(ranks))
        for (j, (l, u)) in enumerate(zip(rank_range, rank_range[2:end]))
            out[j, i] = sum(x -> Base.isbetween(l, x, u), col)
        end
    end
    return out
end

centers(x::StepRangeLen) = [mean(steps) for steps in zip(x, x[2:end])]

function padx!(r, xs)
    pushfirst!(xs, minimum(r))
    push!(xs, maximum(r))
    return xs
end

function pady!(ys)
    pushfirst!(ys, first(ys))
    push!(ys, last(ys))
    return ys
end
