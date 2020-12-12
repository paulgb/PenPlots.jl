
function to_path_string(path::Path)
	string("M", join(["$(point.x),$(point.y)" for point in path], "L"))
end
