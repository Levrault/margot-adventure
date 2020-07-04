extends Node2D

onready var player: Player = find_node("Player")


func _exit_tree() -> void:
	Events.emit_signal("room_transition_started")


func _ready():
	RoomManager.bounds = {
		'limit_left': $BoundsNW.global_position.x,
		'limit_top': $BoundsNW.global_position.y,
		'limit_right': $BoundsSE.global_position.x,
		'limit_bottom': $BoundsSE.global_position.y,
	}
	Events.emit_signal("room_limit_changed", RoomManager.bounds)

	if RoomManager.gate_to_spawn != "":
		Events.emit_signal(
			"player_room_entered",
			$Gates.get_node(RoomManager.gate_to_spawn).get_node("Spawn").global_position
		)

	Events.emit_signal("room_transition_ended")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_restart_level"):
		get_tree().reload_current_scene()
		return

	if event.is_action_pressed("debug_spawn"):
		player.state_machine.transition_to("Spawn")
		return

	if event.is_action_pressed("debug_die"):
		player.state_machine.transition_to("Die")
		return

	if event.is_action_pressed("debug_slow_time"):
		Engine.time_scale = .1
		return

	if event.is_action_pressed("debug_accelerate_time"):
		Engine.time_scale = Engine.time_scale + .1
		return

	if event.is_action_pressed("debug_reset_time"):
		Engine.time_scale = 1.0
		return

	if event.is_action_pressed("debug_free_camera"):
		player.is_handling_input = not player.is_handling_input
		if not player.is_handling_input:
			var free_camera: Camera2D = load("res://src/Tools/FreeCamera.tscn").instance()
			free_camera.position = player.position
			add_child(free_camera)
		else:
			get_node("FreeCamera").queue_free()
