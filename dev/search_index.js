var documenterSearchIndex = {"docs":
[{"location":"library/#Library","page":"Library","title":"Library","text":"","category":"section"},{"location":"library/","page":"Library","title":"Library","text":"Modules = [PenPlots]","category":"page"},{"location":"library/#PenPlots.unitvec","page":"Library","title":"PenPlots.unitvec","text":"The unit vector (0, 1).\n\nUseful for creating n-gons, e.g.:\n\nusing PenPlots\n\nexpect = [\n    [-1, 0],\n    [0, -1],\n    [1, 0],\n    [0, 1],\n]\n\nisapprox(expect, [frac_rotation(i/4) * unitvec for i in 1:4])\n\n# output\n\ntrue\n\n\n\n\n\n","category":"constant"},{"location":"library/#PenPlots.Extent","page":"Library","title":"PenPlots.Extent","text":"A pair of Points representing a rectangle.\n\n\n\n\n\n","category":"type"},{"location":"library/#PenPlots.Layer","page":"Library","title":"PenPlots.Layer","text":"Represents a layer of a plot.\n\nA \"layer\" is a full pass of one pen. A layer has an associated color which is used for previewing the plot in the SVG export, but the color is not used by the plotting software.\n\n\n\n\n\n","category":"type"},{"location":"library/#PenPlots.MultiPath","page":"Library","title":"PenPlots.MultiPath","text":"An array of paths. Corresponds one-to-one with a layer in a plot.\n\n\n\n\n\n","category":"type"},{"location":"library/#PenPlots.Path","page":"Library","title":"PenPlots.Path","text":"A 1-dimensional array of Points.\n\n\n\n\n\n","category":"type"},{"location":"library/#PenPlots.PenPlot","page":"Library","title":"PenPlots.PenPlot","text":"A plot, consisting of one or more layers.\n\nConstructed with:\n\nPenPlot(layers...)\n\nConstruct a pen plot consisting of the given layers.\n\nLayers may be:\n\nLayer objects\nMultiPath objects\nPair{String, MultiPath} objects, where the string becomes the name of the layer.\n\n\n\n\n\n","category":"type"},{"location":"library/#PenPlots.center-Tuple{Extent}","page":"Library","title":"PenPlots.center","text":"Compute the center of an Extent as a Point.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.combine_extents-Tuple{Extent,Extent}","page":"Library","title":"PenPlots.combine_extents","text":"Compute an extent which encompasses the given two Extents.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.degree_rotation-Tuple{Real}","page":"Library","title":"PenPlots.degree_rotation","text":"degree_rotation(deg)\n\nCreate a rotation matrix for the angle given in degrees.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.extent-Tuple{Array{Path,1}}","page":"Library","title":"PenPlots.extent","text":"Compute an extent which encompasses the given MultiPath.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.extent-Tuple{Layer}","page":"Library","title":"PenPlots.extent","text":"Compute an extent which encompasses the given Layer.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.extent-Tuple{Path}","page":"Library","title":"PenPlots.extent","text":"Compute an extent which encompasses the given Path.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.extent-Tuple{PenPlot}","page":"Library","title":"PenPlots.extent","text":"Compute an extent which encompasses the given PenPlot.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.frac_rotation-Tuple{Real}","page":"Library","title":"PenPlots.frac_rotation","text":"frac_rotation(frac)\n\nCreate a rotation matrix for the angle given as a fraction, i.e. 1.0 represents a full rotation and 0.5 a half rotation.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.perlin_noise-Tuple{Any,Point}","page":"Library","title":"PenPlots.perlin_noise","text":"perlin_noise(control_points, point)\n\nCompute the noise gradient for the given point, given a grid of control points.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.point_matrix-Tuple{Any,Any}","page":"Library","title":"PenPlots.point_matrix","text":"point_matrix(xs, ys)\n\nGenerate a matrix by producing Points for the cartesian product of the vectors of x and y values given. The resulting matrix will have as many columns as entries of xs, and as many rows as values of ys.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.radian_rotation-Tuple{Real}","page":"Library","title":"PenPlots.radian_rotation","text":"radian_rotation(rad)\n\nCreate a rotation matrix for the angle given in radians.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.random_vector_matrix-Tuple{Any,Any,Any}","page":"Library","title":"PenPlots.random_vector_matrix","text":"random_vector_matrix([rng,] rows, cols)\n\nProduce a matrix with the given number of rows and columns, in which every entry is a random unit vector. If provided, the given random number generator is used to determine the vectors.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.to_path_string-Tuple{Path}","page":"Library","title":"PenPlots.to_path_string","text":"to_path_string(path)\n\nReturns SVG path syntax for the given path.\n\n\n\n\n\n","category":"method"},{"location":"library/#PenPlots.to_svg-Tuple{PenPlot}","page":"Library","title":"PenPlots.to_svg","text":"to_svg(plot)\n\nReturns an SVG representation of the given plot as a string.\n\n\n\n\n\n","category":"method"},{"location":"#PenPlots.jl","page":"PenPlots.jl","title":"PenPlots.jl","text":"","category":"section"},{"location":"","page":"PenPlots.jl","title":"PenPlots.jl","text":"PenPlots.jl is a Julia library for creating and exporting pen plots in Julia. Currently, it is capable of producing SVG files suitable for use with AxiDraw's Inkscape plugin, saxi, and most other tools that consume SVG.","category":"page"},{"location":"","page":"PenPlots.jl","title":"PenPlots.jl","text":"PenPlots integrates with Pluto.jl by rendering plot objects as an inline preview, with a button to download the SVG directly.","category":"page"},{"location":"#Data-Representation","page":"PenPlots.jl","title":"Data Representation","text":"","category":"section"},{"location":"","page":"PenPlots.jl","title":"PenPlots.jl","text":"PenPlots represents plots through a hierarchy of types, as follows:","category":"page"},{"location":"","page":"PenPlots.jl","title":"PenPlots.jl","text":"PenPlot represents an entire plot, consisting of one or more Layers\nLayer represents a layer of a plot, consisting of exactly one MultiPath.\nMultiPath represents all of the lines in a layer, consisting of one or more Path.\nPath represents a continuous string of lines, consisting of two or more Points.","category":"page"},{"location":"","page":"PenPlots.jl","title":"PenPlots.jl","text":"Points represent a point in the GeometryBasics.jl library.","category":"page"},{"location":"","page":"PenPlots.jl","title":"PenPlots.jl","text":"A \"layer\" corresponds to an uninterrupted sequence of movements by the plotter, which usually includes movements both with the pen up and with the pen down. A plot can consist of multiple layers, between which the pen can be changed, in order to produce multi-colored plots.","category":"page"},{"location":"","page":"PenPlots.jl","title":"PenPlots.jl","text":"The Layer struct contains metadata about the layer, namely its color and identifier. The color is used for preview only and is not understood by plotter software. The identifier is used as the id for the layer's group in the resulting SVG.","category":"page"},{"location":"","page":"PenPlots.jl","title":"PenPlots.jl","text":"Saxi doesn't really care about how you name layers, but AxiDraw's Inkscape plugin has certain naming conventions that must be followed. By default, if names are not provided (see the different ways a PenPlot can be constructed), layers will be automatically named in a way that each begins with a unique number, for compatibility with both approaches.","category":"page"}]
}
