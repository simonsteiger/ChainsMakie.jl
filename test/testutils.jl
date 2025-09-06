function continuous_samples(; n = 300, p = 4, c = 4)
    A = randn(StableRNG(42), n, p, c)
    for i in axes(A, 2)
        A[:, i, :] .+= i - 2
    end
    return A
end

function discrete_samples(; n = 300, p = 1, c = 4)
    return reshape(repeat(1:4, n ÷ 4 * c * p), (n, p, c))
end

function testchains(a = continuous_samples())
    p = size(a, 2)
    parameters = [:A, :B, :C, :D, :E]
    @assert p < length(parameters)
    return Chains(a, first(parameters, p))
end
