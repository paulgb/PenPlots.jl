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

"""
A plot, consisting of one or more layers.

Constructed with:

    PenPlot(layers...)

Construct a pen plot consisting of the given layers.

Layers may be:
- [`Layer`]{@ref} objects
- [`MultiPath`]{@ref} objects
- `Pair{String, MultiPath}` objects, where the string becomes the name of
the layer.
"""
struct PenPlot
    layers::Array{Layer}

    function PenPlot(layers...)
        new_layers = []
        layer_maker = LayerMaker(length(layers))

        new_layers = map(collect(layers)) do layerdata
            makelayer(layer_maker, layerdata)
        end
        new(new_layers)
    end
end
