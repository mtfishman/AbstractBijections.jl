using AbstractBijections
using Suppressor
using Test

@testset "AbstractBijections.jl" begin
  f = Bijection(["X1", "X2"], ["Y1", "Y2"])
  @test f["X1"] == "Y1"
  @test inv(f)["Y1"] == "X1"
  @test domain(f) == ["X1", "X2"]
  @test image(f) == ["Y1", "Y2"]

  f = bijection(["X1" => "Y1", "X2" => "Y2"])
  @test f["X1"] == "Y1"
  @test inv(f)["Y1"] == "X1"

  f = Bijection(["Y1", "Y2"])
  @test f[1] == "Y1"
  @test inv(f)["Y1"] == 1
end

@testset "examples.jl" begin
  examples_path = joinpath(pkgdir(AbstractBijections), "examples")
  files = readdir(examples_path; join=true)
  for file in files
    @suppress include(file)
  end
end
