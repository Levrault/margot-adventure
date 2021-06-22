extends VBoxContainer


func _ready():
	Events.connect("collectable_collected", self, "_on_Collectable_collected")
	Events.connect("collectable_animation_completed", self, "_on_Collectable_collected")
	$Timer.connect("timeout", self, "_on_Timeout")
	$Timer.start()


func toggle_fade_in_out(type: String) -> void:
	var alpha := 1.0 if type == "in" else 0.0

	$Tween.interpolate_property(
		self, "modulate:a", self.modulate.a, alpha, 1, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	$Tween.start()


func _on_Timeout() -> void:
	toggle_fade_in_out("out")


func _on_Collectable_collected(selected_character: int, score: int) -> void:
	toggle_fade_in_out("in")
	$Timer.stop()
	$Timer.start()
