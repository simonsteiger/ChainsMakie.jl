@recipe(TrankPlot) do scene
    Attributes(
        color = nothing, # TODO define a safe way to map custom colors -- maybe take `colormap` instead?
        linewidth = 1.5,
        bins = 20,
    )
end

function Makie.plot!(tp::TrankPlot{<:Tuple{<:AbstractMatrix}})
    mat = tp[1]
    binmat = lift((m, bins) -> bin_chain(m; bins), mat, tp.bins)
    
    xs = lift(mat, tp.bins) do m, length
        r = range(1, size(m, 1); length)
        padx!(r, centers(r))
    end

    for col in eachcol(to_value(binmat)) # FIXME interactivity?
        ys = pady!(collect(col))
        stairs!(tp, xs, ys; step = :center)
    end
    
    return tp
end

function trankplot(chains::Chains, parameters; kwargs...)
    fig = Figure()
    for (i, parameter) in enumerate(parameters)
        ax = Axis(fig[i, 1], ylabel = string(parameter))
        trankplot!(chains[:, parameter, :]; kwargs...)
    
        hideydecorations!(ax; label=false)
        if i < length(parameters)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Iteration"
        end    
    end
    
    return fig
end

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
