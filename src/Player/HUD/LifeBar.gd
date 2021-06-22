extends TextureRect

onready var timer := $Timer
onready var tween := $Tween


func _ready() -> void:
	timer.connect("timeout", self, "_on_Timeout")
	timer.start()


func show_ui() -> void:
	tween.stop_all()
	tween.interpolate_property(
		self, "modulate:a", self.modulate.a, 1, .150, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	tween.start()

	timer.start()


func _on_Timeout() -> void:
	tween.interpolate_property(
		self, "modulate:a", self.modulate.a, 0.0, 1, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR
	)
	tween.start()
