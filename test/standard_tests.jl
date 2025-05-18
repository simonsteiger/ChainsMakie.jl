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

@testset "Ridgeline inputs" begin
    chns = testchains()
    fig1, ax1, plt1 = ridgeline(chns, ["A", "B"])
    @test fig1 isa Figure
    fig2, ax2, plt2 = ridgeline(chns, [:A, :B])
    @test fig2 isa Figure
end