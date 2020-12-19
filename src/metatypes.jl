import StaticArrays.SVector
import Colors: RGB, distinguishable_colors
import GeometryBasics: Point

export Layer, PenPlot

"""
Represents a layer of a plot.

A "layer" is a full pass of one pen. A layer has an associated color which
is used for previewing the plot in the SVG export, but the color is not used
by the plotting software.
"""
struct Layer
    name::String
    paths::MultiPath
    color::RGB
end

mutable struct LayerMaker
    num_layers::Int
    default_colors::Array{RGB,1}
    current_index::Int

    function LayerMaker(num_layers::Int)
        default_colors = distinguishable_colors(num_layers, lchoices = 0:40)
        new(num_layers, default_colors, 1)
    end
end

function makelayer(layer_maker::LayerMaker, layer::Layer)
    layer_maker.current_index += 1
    layer
end

function makelayer(layer_maker::LayerMaker, paths::MultiPath)
    name = "$(layer_maker.current_index)-layer"
    color = layer_maker.default_colors[layer_maker.current_index]
    layer_maker.current_index += 1
    Layer(name, paths, color)
end

function makelayer(layer_maker::LayerMaker, name_paths_pair::Pair{String,MultiPath})
    color = layer_maker.default_colors[layer_maker.current_index]
    layer_maker.current_index += 1
    Layer(name_paths_pair.first, name_paths_pair.second, color)
end

function makenotch(corner::Point, prev::Point, next::Point; frac=0.05)
    p1 = prev * frac + corner * (1-frac)
    p2 = corner
    p3 = next * frac + corner * (1-frac)
    Path([p1, p2, p3])
end

"""
A plot, consisting of one or more layers.

Constructed with:

    PenPlot(layers...)

Construct a pen plot consisting of the given layers.

Layers may be:
- [`Layer`](@ref) objects
- [`MultiPath`](@ref) objects
- `Pair{String, MultiPath}` objects, where the string becomes the name of
  the layer.
"""
struct PenPlot
    layers::Array{Layer}

    function PenPlot(layers...; addoutline=false)
        new_layers = []
        layer_maker = LayerMaker(length(layers) + (addoutline ? 1 : 0))

        new_layers = map(collect(layers)) do layerdata
            makelayer(layer_maker, layerdata)
        end
        plot = new(new_layers)

        if addoutline
            plx = extent(plot)

            upperright = Point(plx.lowerright[1], plx.upperleft[2])
            lowerleft = Point(plx.upperleft[1], plx.lowerright[2])

            outline = [
                makenotch(plx.upperleft, lowerleft, upperright),
                makenotch(upperright, plx.upperleft, plx.lowerright),
                makenotch(plx.lowerright, upperright, lowerleft),
                makenotch(lowerleft, plx.lowerright, plx.upperleft),
            ]
            push!(plot.layers, makelayer(layer_maker, outline))
        end

        plot
    end
end
