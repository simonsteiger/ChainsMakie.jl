chns_continuous = testchains()
chns_discrete = testchains(discrete_samples(; p = 3))
@testset "Error too few colors" begin
    foreach([traceplot, trankplot, chainsdensity, chainshist]) do f
        @test try
            f(chns_continuous, ["A", "B"]; color = [:red, :blue])
        catch e
            e isa ErrorException
        end
    end
    @test try
        barplot(chns_discrete, ["A", "B"]; color = [:red, :blue])
    catch e
        e isa ErrorException
    end
end
