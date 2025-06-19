extends MeshInstance3D

const SHOOT_POS := Vector3(0.65, -0.44, -1.74)
const SHOOT_ROT := Vector3(deg_to_rad(5.0), deg_to_rad(173.8), 0.0)

const RUN_POS := Vector3(-0.64, -0.63, -1.21)
const RUN_ROT := Vector3(deg_to_rad(17.4), deg_to_rad(229.6), deg_to_rad(-23.0))

const RELOAD_POS := Vector3(-0.33, -1.09, -1.22)
const RELOAD_ROT := Vector3(deg_to_rad(39.3), deg_to_rad(210.6), deg_to_rad(-23.0))

var target_pos = SHOOT_POS
var target_rot = SHOOT_ROT

var reload_thread: Thread
var reloading := false

func _process(delta: float) -> void:
	
	position = lerp(position, target_pos, delta * 15);
	rotation = lerp(rotation, target_rot, delta * 15);
	
	if not reloading:
		
		var run_amount := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized().length()
		
		if run_amount > 0:
			
			target_pos = RUN_POS + Vector3(
				cos(Time.get_ticks_msec() * 0.01) * 0.03,
				abs(sin(Time.get_ticks_msec() * 0.01) * 0.03),
				0.0
			)
			target_rot = RUN_ROT
		else:
			target_pos = SHOOT_POS
			target_rot = SHOOT_ROT
		
		if Input.is_action_pressed("fire"):
			
			var random = RandomNumberGenerator.new()
			var flare_scale = random.randf_range(0.8, 1.0)
			
			$MuzzleFlare.visible = true
			$MuzzleFlare.rotation.z = random.randf_range(0.0, 0.3)
			$MuzzleFlare.scale = Vector3(flare_scale, flare_scale, flare_scale)
			position = SHOOT_POS
			rotation = SHOOT_ROT
			position.z += random.randf_range(0.0, 0.1)
		else:
			$MuzzleFlare.visible = false

func do_reload_animation(player: Node3D):
	
	player.can_shoot = false
	reloading = true
	
	target_pos = RELOAD_POS
	target_rot = RELOAD_ROT
	
	if reload_thread:
		reload_thread.wait_to_finish()

	reload_thread = Thread.new()
	reload_thread.start(reload_animation.bind(player))

func reload_animation(player: Node3D):
	
	OS.delay_msec(1000)
	
	player.can_shoot = true
	reloading = false
	
	if player.reserve_ammo >= player.max_clip_ammo - player.clip_ammo:
		player.reserve_ammo -= player.max_clip_ammo - player.clip_ammo
		player.clip_ammo = player.max_clip_ammo
	else:
		player.clip_ammo += player.reserve_ammo
		player.reserve_ammo = 0
	
	player.call_deferred("update_ammo_gui")

func _exit_tree():
	
	if reload_thread:
		reload_thread.wait_to_finish()
