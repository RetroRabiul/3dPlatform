extends Spatial


var finished: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$background.play()
	$"%EndSlideCollision".disabled = false


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		$playerdied.play()
		yield($playerdied, "finished")
		get_tree().change_scene("res://scenes/world.tscn")
		GlobalVariables.time = 0
		GlobalVariables.stopped = true
		GlobalVariables.can_collide = false


func _on_Timer_Starts_body_entered(body):
	if body.is_in_group("player"):
		finished = false
		GlobalSignal.emit_signal("start_timer")


func _on_WinningArea_body_entered(body):
	if body.is_in_group("player") and not finished:
		finished = true
		GlobalSignal.emit_signal("stop_timer")
		$"%EndSlideCollision".disabled = true
		SilentWolf.Scores.persist_score(GlobalVariables.player_name,GlobalVariables.time)


func _on_StopSlide_body_exited(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("reset")
		$"%EndSlideCollision".disabled = false
	


func _on_SlideArea_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("start_sliding")

