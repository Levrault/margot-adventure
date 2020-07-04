extends State

export var max_speed_sprint := 900.0


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		owner.attack_factory.create("attack_run")
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	_parent.max_speed.x = max_speed_sprint if Input.is_action_pressed("sprint") else _parent.max_speed_default.x
	if owner.is_on_floor():
		if _parent.velocity.length() < 1.0:
			_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air", { coyote_time = true })
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)



func exit() -> void:
	_parent.exit()
