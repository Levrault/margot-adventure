extends State

var _start_position := Vector2.ZERO


func _ready() -> void:
	yield(owner, "ready")
	_start_position = owner.position


func enter(msg: Dictionary = {}) -> void:
	owner.position = _start_position
	owner.is_active = false
	if owner.camera_rig:
		owner.camera_rig.is_active = false

	owner.skin.play("spawn")
	owner.skin.connect("animation_finished", self, "_on_Skin_animation_finished")


func exit() -> void:
	owner.is_active = true

	if has_user_signal("animation_finished"):
		owner.skin.disconnect("animation_finished", self, "_on_Skin_animation_finished")


func _on_Skin_animation_finished(anim_name: String) -> void:
	_state_machine.transition_to("Move/Idle")
