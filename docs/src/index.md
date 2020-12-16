# PenPlots.jl

**PenPlots.jl** is a [Julia](https://julialang.org/) library for creating and
exporting pen plots in Julia. Currently, it is capable of producing SVG files
suitable for use with [AxiDraw's Inkscape plugin](https://wiki.evilmadscientist.com/Axidraw_Software_Installation),
[saxi](https://github.com/nornagon/saxi), and most other tools that consume SVG.

PenPlots integrates with [Pluto.jl](https://github.com/fonsp/Pluto.jl) by
rendering plot objects as an inline preview, with a button to download the SVG
directly.

## Data Representation

PenPlots represents plots through a hierarchy of types, as follows:

- [`PenPlot`](@ref) represents an entire plot, consisting of one or more [`Layer`](@ref)s
  - [`Layer`](@ref) represents a layer of a plot, consisting of exactly one [`MultiPath`](@ref).
    - [`MultiPath`](@ref) represents all of the lines in a layer, consisting of one or more [`Path`](@ref).
      - [`Path`](@ref) represents a continuous string of lines, consisting of two or more `Point`s.

`Point`s represent a point in the [`GeometryBasics.jl`](https://juliageometry.github.io/GeometryBasics.jl/stable/)
library.

A "layer" corresponds to an uninterrupted sequence of movements by the plotter,
which usually includes movements both with the pen up and with the pen down.
A plot can consist of multiple layers, between which the pen can be changed,
in order to produce multi-colored plots.

The [`Layer`](@ref) struct contains metadata about the layer, namely its color
and identifier. The color is used for preview only and is not understood by
plotter software. The identifier is used as the `id` for the layer's group in
the resulting SVG.

Saxi doesn't really care about how you name layers, but AxiDraw's Inkscape
plugin has [certain naming conventions](https://wiki.evilmadscientist.com/AxiDraw_Layer_Control)
that must be followed. By default, if names are not provided (see the different
ways a [`PenPlot`](@ref) can be constructed), layers will be automatically
named in a way that each begins with a unique number, for compatibility with
both approaches.
