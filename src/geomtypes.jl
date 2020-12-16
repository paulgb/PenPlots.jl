import StaticArrays.SVector
import GeometryBasics: Point
import Rotations.RotMatrix

export Point, Path, MultiPath, unitvec

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
