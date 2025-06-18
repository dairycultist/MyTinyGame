extends MeshInstance3D

const SHOOT_POS = Vector3(0.65, -0.44, -1.74)
const SHOOT_ROT = Vector3(deg_to_rad(5.0), deg_to_rad(173.8), 0.0)

const RUN_POS = Vector3(-0.64, -0.63, -1.21)
const RUN_ROT = Vector3(deg_to_rad(17.4), deg_to_rad(229.6), deg_to_rad(-23.0))

func _process(delta: float) -> void:
	
	var move := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized().length()
	
	position = lerp(SHOOT_POS, RUN_POS + Vector3(cos(Time.get_ticks_msec() * 0.01) * 0.03, abs(sin(Time.get_ticks_msec() * 0.01) * 0.03), 0.0), move)
	rotation = lerp(SHOOT_ROT, RUN_ROT, move)
