using AbstractBijections
using Documenter

DocMeta.setdocmeta!(AbstractBijections, :DocTestSetup, :(using AbstractBijections); recursive=true)

makedocs(;
    modules=[AbstractBijections],
    authors="Matthew Fishman <mfishman@flatironinstitute.org> and contributors",
    repo="https://github.com/mtfishman/AbstractBijections.jl/blob/{commit}{path}#{line}",
    sitename="AbstractBijections.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://mtfishman.github.io/AbstractBijections.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mtfishman/AbstractBijections.jl",
    devbranch="main",
)
