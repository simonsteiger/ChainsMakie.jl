_xlabel(i) = iszero(i % 2) ? "Parameter estimate" : "Iteration"

function Makie.plot(chains::Chains; size = nothing, hidey = false)
    parameters = names(chains)
    n_params = length(parameters)
    
    if isnothing(size)
        size = (600, n_params * 200)
    end
    fig = Figure(; size)
    
    for i in 1:n_params * 2
        coord = fldmod1(i, 2)
        param_idx = first(coord)
        ax = Axis(fig[coord...])
        if iszero(i % 2)
            chainsdensity!(chains[:, param_idx, :])
        else
            traceplot!(chains[:, param_idx, :])
        end
        hidex = param_idx < n_params
        _axisdecorations!(ax, hidex, _xlabel(i), hidey, parameters[param_idx])
    end
    
    axes = [only(contents(fig[i, 2])) for i in 1:n_params]
    linkxaxes!(axes...)
    
    return fig
end
