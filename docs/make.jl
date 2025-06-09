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
        "Introduction" => "introduction.md",
        "Composing plots" => "composing_plots.md",
        "Plot types" => [
            "Autocorrelation" => "plot_types/autocorplot.md",
            "Density" => "plot_types/density.md",
            "Forest plot" => "plot_types/forestplot.md",
            "Histogram" => "plot_types/hist.md",
            "Running average" => "plot_types/meanplot.md",
            "Ridgeline" => "plot_types/ridgeline.md",
            "Traceplot" => "plot_types/traceplot.md",
            "Trankplot" => "plot_types/trankplot.md",
        ],
        "api.md",
    ],
    pagesonly = true,
)

DocumenterVitepress.deploydocs(;
    repo = "github.com/simonsteiger/ChainsMakie.jl",
    devbranch = "main",
    push_preview = true,
)