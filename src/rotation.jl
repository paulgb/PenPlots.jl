import Rotations.RotMatrix

function degree_rotation(deg::Real)
    RotMatrix(pi*(deg/180))
end

function frac_rotation(frac::Real)
    RotMatrix(2*pi*frac)
end

function radian_rotation(rad::Real)
    RotMatrix(rad)
end

export degree_rotation, frac_rotation, radian_rotation
