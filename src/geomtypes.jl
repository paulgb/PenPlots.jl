import StaticArrays.SVector
import GeometryBasics: Point
import Rotations.RotMatrix

export Point, Path, MultiPath, unitvec, point_matrix

"""
The unit vector (0, 1).

Useful for creating n-gons, e.g.:

```jldoctest
using PenPlots

expect = [
    [-1, 0],
    [0, -1],
    [1, 0],
    [0, 1],
]

isapprox(expect, [frac_rotation(i/4) * unitvec for i in 1:4])

# output

true
```
"""
const unitvec = Point(0, 1)

"""
A 1-dimensional array of `Point`s.
"""
struct Path <: AbstractVector{Point}
    points::Vector{Point}
end

function Base.size(path::Path)
    size(path.points)
end

function Base.getindex(path::Path, i::Int64)
    getindex(path.points, i)
end

"""
An array of paths. Corresponds one-to-one with a layer in a plot.
"""
const MultiPath = Vector{Path}

# Rotation by a matrix.

function Base.:*(rot::RotMatrix, path::Path)
    Path([rot * point for point in path.points])
end

function Base.:*(rot::RotMatrix, paths::MultiPath)
    MultiPath([rot * path for path in paths])
end

# Multiplication by a point.

function Base.:*(point::Point, path::Path)
    Path([point * x for x in path])
end

function Base.:*(point::Point, paths::MultiPath)
    MultiPath([point * path for path in paths])
end

# Addition with a point.

function Base.:+(point::Point, path::Path)
    Path([point + x for x in path])
end

function Base.:+(point::Point, paths::MultiPath)
    MultiPath([point + path for path in paths])
end

"""
    point_matrix(xs, ys)

Generate a matrix by producing `Point`s for the cartesian product of the vectors
of `x` and `y` values given. The resulting matrix will have as many columns as
entries of `xs`, and as many rows as values of `ys`.
"""
function point_matrix(xs, ys)
	xxs = xs' .* ones(length(ys))
	yys = ys .* ones(length(xs))'
	Point.(xxs, yys)
end
