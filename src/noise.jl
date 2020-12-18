import LinearAlgebra.dot
import GeometryBasics: Point

export control_points, perlin_noise

"""
    control_points(rng, rows, cols)

Produce a grid of control points for use in Perlin noise.
"""
function control_points(rng, rows, cols)
	map(frac_rotation.(rand(rng, rows, cols))) do rot
		rot * unitvec
	end
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

    res[col, row] = smoothstep(
        smoothstep(n00, n01, yf),
        smoothstep(n10, n11, yf),
        xf
    )
end
