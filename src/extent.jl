export Extent, extent

"""
A pair of `Point`s representing a rectangle.
"""
struct Extent
    upperleft::Point
    lowerright::Point
end

"""
Compute the center of an `Extent` as a `Point`.
"""
function center(ext::Extent)
    (ext.upperleft + ext.lowerright) / 2
end

"""
Compute an extent which encompasses the given two `Extent`s.
"""
function combine_extents(ext1::Extent, ext2::Extent)
    Extent(min.(ext1.upperleft, ext2.upperleft), max.(ext1.lowerright, ext2.lowerright))
end

"""
Compute an extent which encompasses the given `Path`.
"""
function extent(path::Path)
    upperleft = lowerright = path[1]
    for point in path
        upperleft = min.(upperleft, point)
        lowerright = max.(lowerright, point)
    end
    Extent(upperleft, lowerright)
end

"""
Compute an extent which encompasses the given `MultiPath`.
"""
function extent(paths::MultiPath)
    reduce(combine_extents, [extent(path) for path in paths])
end

"""
Compute an extent which encompasses the given `Layer`.
"""
function extent(layer::Layer)
    extent(layer.paths)
end

"""
Compute an extent which encompasses the given `PenPlot`.
"""
function extent(plot::PenPlot)
    reduce(combine_extents, [extent(layer) for layer in plot.layers])
end
