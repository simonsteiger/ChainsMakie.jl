using ChainsMakie
using Documenter
using DocumenterVitepress
using CairoMakie

DocMeta.setdocmeta!(ChainsMakie, :DocTestSetup, :(using ChainsMakie); recursive=true)

makedocs(;
    modules = [ChainsMakie],
    authors = "Simon Steiger and contributors",
    sitename = "ChainsMakie.jl",
    format = DocumenterVitepress.MarkdownVitepress(;
        repo = "https://github.com/simonsteiger/ChainsMakie.jl",
        devurl = "dev",
        devbranch = "main",
    ),
    pages=[
        "Home" => "index.md",
        "Reference" => "reference.md",
        "api.md",
    ],
    pagesonly = true,
)

DocumenterVitepress.deploydocs(;
    repo = "github.com/simonsteiger/ChainsMakie.jl",
    devbranch = "main",
    push_preview = true,
)