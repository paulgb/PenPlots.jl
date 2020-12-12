import StaticArrays.SVector
import GeometryBasics: Point
import Rotations.RotMatrix

export Point, Path, MultiPath

struct Path <: AbstractVector{Point}
    points::Vector{Point}
end

function Base.size(path::Path)
    size(path.points)
end

function Base.getindex(path::Path, i::Int64)
    getindex(path.points, i)
end

const MultiPath = Vector{Path}

"""Rotation by a matrix"""

function Base.:*(rot::RotMatrix, path::Path)
    Path([
        rot * point for point in path.points
    ])
end

function Base.:*(rot::RotMatrix, paths::MultiPath)
    MultiPath([
        rot * path for path in paths
    ])
end

"""Multiplication by a point"""

function Base.:*(point::Point, path::Path)
    Path([
        point * x for x in path
    ])
end

function Base.:*(point::Point, paths::MultiPath)
    MultiPath([
        point * path for path in paths
    ])
end

"""Addition with a point"""

function Base.:+(point::Point, path::Path)
    Path([
        point + x for x in path
    ])
end

function Base.:+(point::Point, paths::MultiPath)
    MultiPath([
        point + path for path in paths
    ])
end
