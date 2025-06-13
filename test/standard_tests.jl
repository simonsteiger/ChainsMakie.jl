@testset "Error too few colors" begin
    chns_continuous = testchains()
    chns_discrete = testchains(discrete_samples(; p = 3))
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

@testset "Forestplot errors" begin
    chns = testchains()
    @test try
        forestplot(chns, [:A, :B, :C], point_summary = x -> quantile(x, [0.5, 0.6]))
    catch e
        e isa ErrorException
    end
end

@testset "Mutating versions" begin
    chns = testchains()
    fig = Figure()
    @test violin!(chns) isa Figure
end
