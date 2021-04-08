import Base64.base64encode
import Colors.hex

export to_svg

"""
    to_path_string(path)

Returns SVG path syntax for the given path.
"""
function to_path_string(path::Path)
    string("M", join(["$(point[1]),$(point[2])" for point in path], "L"))
end

"""
	to_svg(plot)

Returns an SVG representation of the given plot as a string.
"""
function to_svg(plot::PenPlot)
    repr(MIME"image/svg+xml"(), plot)
end

Base.show(io::IO, ::MIME"image/svg+xml", plot::PenPlot)
    ext = extent(plot)
    width = ext.lowerright[1] - ext.upperleft[1]
    height = ext.lowerright[2] - ext.upperleft[2]

    print(
        io,
        """<svg
xmlns="http://www.w3.org/2000/svg"
height="400"
width="100%"
viewBox="$(ext.upperleft[1]) $(ext.upperleft[2]) $(width) $(height)">""",
    )

    for layer in plot.layers
        print(
            io,
            """<g id="$(layer.name)"
stroke="#$(hex(layer.color))"
opacity="0.5"
fill="none">""",
        )

        for path in layer.paths
            print(
                io,
                """<path
  d="$(to_path_string(path))"
  vector-effect="non-scaling-stroke"
  />""",
            )
        end

        print(io, "</g>")
    end

    print(io, "</svg>")
end

function Base.show(io::IO, mime::MIME"image/svg+xml", path::Path)
    plot = PenPlot([path])
    Base.show(io, mime, plot)
end

function Base.show(io::IO, mime::MIME"image/svg+xml", paths::MultiPath)
    plot = PenPlot(paths)
    Base.show(io, mime, plot)
end
