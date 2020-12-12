using PenPlots
using Test
import GeometryBasics: Point

import Colors.RGB

function Base.isapprox(path1::Path, path2::Path)
    all(isapprox.(path1.points, path2.points))
end

function Base.isapprox(multipath1::MultiPath, multipath2::MultiPath)
    all(isapprox.(multipath1, multipath2))
end

paths = [
    Path([
        Point(4, 5),
        Point(5, 13),
        Point(2, 10),
    ]),
    Path([
        Point(1, 2),
        Point(9, 1),
        Point(4, 17),
    ])
]

@testset "Geometric Algebra Tests" begin
    @test 4 * paths == [
        [
            p * 4 for p in path
        ]
        for path in paths
    ]

    @test Point(5, 8) * paths == [
        [
            p * Point(5, 8) for p in path
        ]
        for path in paths
    ]

    @test isapprox(degree_rotation(90), frac_rotation(0.25))

    @test isapprox(degree_rotation(90), radian_rotation(pi/2))

    @test isapprox(degree_rotation(90) * paths, [
        [
            Point(-p[2], p[1]) for p in path
        ]
        for path in paths
    ])

    @test Point(3, 6) + paths == [
        [
            Point(3, 6) + p for p in path
        ]
        for path in paths
    ]
end

@testset "Plot Construction Tests" begin
    paths1 = [
        Path([
            Point(4, 5),
            Point(5, 6),
            Point(9, 10),
        ])
    ]

    paths2 = [
        Path([
            Point(1, 2),
            Point(7, 1),
            Point(9, 1),
        ])
    ]
    paths3 = [
        Path([
            Point(2, 3),
            Point(1, 1),
            Point(8, 8),
        ])
    ]

    red = RGB(1, 0, 0)

    plot = PenPlot(
        # Explicit layer
        Layer(
            "mylayer",
            paths1,
            red
        ),

        # Implicit layer
        paths2,

        # Named implicit layer
        "mylayer3" => paths3
    )

    to_svg(plot)
end

@testset "Extent tests" begin
    @test extent(paths[1]) == Extent(
        Point(2, 5),
        Point(5, 13)
    )

    @test extent(paths) == Extent(
        Point(1, 1),
        Point(9, 17)
    )
end
