extends Label

const WAIT_TIME := .25
export (Character.Playable) var character = Character.Playable.FOX

onready var _tween := $Tween

func _ready() -> void:
	Events.connect("collectable_collected", self, "_on_Collectable_collected")


func _on_Collectable_collected(selected_character: int, score: int) -> void:
	$Timer.wait_time = WAIT_TIME
	$Timer.start()
	yield($Timer, "timeout")

	if selected_character != character:
		return
	text = "%s" % score

	var initial_y = rect_position.y

	# go all up
	_tween.interpolate_property(
		self, "rect_position:y", rect_position.y, 0, .150, Tween.EASE_IN, Tween.EASE_IN_OUT
	)
	_tween.start()

	yield(_tween,"tween_completed")

	# reset position
	_tween.interpolate_property(
		self, "rect_position:y", rect_position.y, initial_y, .150, Tween.EASE_IN, Tween.EASE_IN_OUT
	)
	_tween.start()

	yield(_tween,"tween_completed")

	$Timer.wait_time = WAIT_TIME
	$Timer.start()
	yield($Timer, "timeout")

	Events.emit_signal("collectable_animation_completed")
