@recipe(ChainsDensity) do scene
    Attributes(
        color = :default,
        colormap = :default,
        strokewidth = 1,
        alpha = 0.4,
    )
end

function Makie.plot!(cd::ChainsDensity{<:Tuple{<:AbstractMatrix}})
    mat = cd[1]
    color = get_colors(size(mat[], 2); color = cd.color[], colormap = cd.colormap[])
    
    for (i, ys) in enumerate(eachcol(mat[]))
        density!(cd, ys; color = (color[i], cd.alpha[]),
                 strokecolor = color[i], strokewidth = cd.strokewidth[])
    end
    
    return cd
end

# Type piracy, I own neither `density` nor `Chains`?
function Makie.density(chains::Chains, parameters; figure = nothing, kwargs...)
    if !(figure isa Figure)
        figure = Figure(size = autosize(chains[:, parameters, :]))
    end

    for (i, parameter) in enumerate(parameters)
        ax = Axis(figure[i, 1], ylabel = string(parameter))
        
        hideydecorations!(ax; label=false)
        if i < length(parameters)
            hidexdecorations!(ax; grid=false)
        else
            ax.xlabel = "Parameter estimate"
        end

        chainsdensity!(chains[:, parameter, :]; kwargs...)
    end

    color = get_colors(size(chains[:, parameters, :], 3); kwargs...)
    chainslegend(figure, chains[:, parameters, :], color)

    return figure
end

Makie.density(chains::Chains; kwargs...) = density(chains, names(chains); kwargs...)
