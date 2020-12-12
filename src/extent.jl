export Extent, extent

struct Extent
	upperleft::Point
    lowerright::Point
end

function center(ext::Extent)
    (ext.upperleft + ext.lowerright) / 2
end

function combine_extents(ext1::Extent, ext2::Extent)
	Extent(
		min.(ext1.upperleft, ext2.upperleft),
		max.(ext1.lowerright, ext2.lowerright)
	)
end

function extent(path::Path)
	upperleft = lowerright = path[1]
	for point in path
        upperleft = min.(upperleft, point)
        lowerright = max.(lowerright, point)
	end
	Extent(upperleft, lowerright)
end

function extent(paths::MultiPath)
	reduce(combine_extents, [extent(path) for path in paths])
end

function extent(layer::Layer)
    extent(layer.paths)
end

function extent(plot::PenPlot)
    reduce(combine_extents, [extent(layer) for layer in plot.layers])
end
