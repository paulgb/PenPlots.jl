import Rotations.RotMatrix

"""
    degree_rotation(deg)

Create a rotation matrix for the angle given in degrees.
"""
function degree_rotation(deg::Real)
    RotMatrix(pi*(deg/180))
end

"""
    frac_rotation(frac)

Create a rotation matrix for the angle given as a fraction,
i.e. 1.0 represents a full rotation and 0.5 a half rotation.
"""
function frac_rotation(frac::Real)
    RotMatrix(2*pi*frac)
end

"""
    radian_rotation(rad)

Create a rotation matrix for the angle given in radians.
"""
function radian_rotation(rad::Real)
    RotMatrix(rad)
end

export degree_rotation, frac_rotation, radian_rotation
