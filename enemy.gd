extends Node3D

func _ready() -> void:
	
	$NavigationAgent3D.path_desired_distance = 3.0 # to reach a path point
	$NavigationAgent3D.path_max_distance = 3.0 # amount it can stray from path (i.e. to avoid collision)

func _process(delta: float) -> void:
	
	$NavigationAgent3D.target_position = get_node("/root/World/Player").position
	
	position += delta * ($NavigationAgent3D.get_next_path_position() - position).normalized()
