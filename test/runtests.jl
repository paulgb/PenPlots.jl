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

@testset "Geometric Algebra Tests" begin
    paths = [
        Path([
            Point(4, 5),
            Point(5, 6),
            Point(9, 10),
        ]),
        Path([
            Point(1, 2),
            Point(7, 1),
            Point(9, 1),
        ])
    ]

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
end
