import LinearAlgebra.dot
import GeometryBasics.Point
import Random.GLOBAL_RNG

export random_vector_matrix, perlin_noise

"""
    random_vector_matrix([rng,] rows, cols)

Produce a matrix with the given number of rows and columns, in which every
entry is a random unit vector. If provided, the given random number generator
is used to determine the vectors.
"""
function random_vector_matrix(rng, rows, cols)
	map(frac_rotation.(rand(rng, rows, cols))) do rot
		rot * unitvec
	end
end

function random_vector_matrix(rows, cols)
    random_vector_matrix(GLOBAL_RNG, rows, cols)
end

function smoothstep(v1, v2, w)
	w = clamp(w, 0., 1.)
	w = 6. * w^5 - 15. * w^4 + 10. * w^3
	(1. - w) * v1 + w * v2
end

"""
    perlin_noise(control_points, point)

Compute the noise gradient for the given point, given a grid of control points.
"""
function perlin_noise(control_points, point::Point)
    rows, cols = size(control_points)
    cell = convert.(Int, (floor.(point)))
    xi, yi = cell

    offset = point - cell
    xf, yf = offset

    n00 = dot(control_points[xi % rows + 1, yi % cols + 1],
        Point(xf, yf))
    n01 = dot(control_points[xi % rows + 1, (yi + 1) % cols + 1],
        Point(xf, yf - 1))
    n10 = dot(control_points[(xi + 1) % rows + 1, yi % cols + 1],
        Point(xf - 1, yf))
    n11 = dot(control_points[(xi + 1) % rows + 1, (yi + 1) % cols + 1],
        Point(xf - 1, yf - 1))

    smoothstep(
        smoothstep(n00, n01, yf),
        smoothstep(n10, n11, yf),
        xf
    )
end
