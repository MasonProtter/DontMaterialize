using Test, DontMaterialize

function foo(x)
    y = lazy.(x .+ x)
    z = lazy.(2 .* y)
    sum(z)
end

@testset "basics" begin
    x = [1,2,3,4]
    @test lazy.(x .+ x) isa Broadcast.Broadcasted
    @test @allocations(foo(x)) == 0
end
