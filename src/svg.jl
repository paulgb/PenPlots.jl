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
	ext = extent(plot)
	width = ext.lowerright[1] - ext.upperleft[1]
	height = ext.lowerright[2] - ext.upperleft[2]

	builder = IOBuffer()
	print(builder, """<svg
		height="400"
		width="100%"
		viewBox="$(ext.upperleft[1]) $(ext.upperleft[2]) $(width) $(height)">""")

	for layer in plot.layers
		print(builder, """<g id="$(layer.name)"
			stroke="#$(hex(layer.color))"
			opacity="0.5"
			fill="none">""")

		for path in layer.paths
			print(builder, """<path
				d="$(to_path_string(path))"
				vector-effect="non-scaling-stroke"
				/>""")
		end

		print(builder, "</g>")
	end

	print(builder, "</svg>")

	String(take!(builder))
end

function Base.show(io::IO, mime::MIME"text/html", path::Path)
	plot = PenPlot([path])
	Base.show(io, mime, plot)
end

function Base.show(io::IO, mime::MIME"text/html", paths::MultiPath)
	plot = PenPlot(paths)
	Base.show(io, mime, plot)
end

function Base.show(io::IO, mime::MIME"text/html", plot::PenPlot)
	svgdata = to_svg(plot)

	# Write SVG element.
	write(io, svgdata)

	# Write download button.
	data_encoded = base64encode(svgdata)
	url = "data:image/svg+xml;$(data_encoded)"
	write(io, "<div>")
	write(io, """<a href="$(url)" download="plot.svg"><button>Download</button></a>""")
	write(io, "</div>")
end
