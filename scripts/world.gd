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


func _on_WinningArea_body_entered(body):
	if body.is_in_group("player") and not finished:
		finished = true
		GlobalSignal.emit_signal("stop_timer")
		$"%EndSlideCollision".disabled = true
		
		var name_to_use = GlobalVariables.player_name + "-" + GlobalVariables.difficulty
		
		SilentWolf.Scores.persist_score(name_to_use,GlobalVariables.time)


func _on_StopSlide_body_exited(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("reset")
		$"%EndSlideCollision".disabled = false
	


func _on_SlideArea_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("start_sliding")


func _on_Easy_Timer_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.difficulty = "E"
		finished = false
		GlobalSignal.emit_signal("start_timer")


func _on_Hard_Timer_body_entered(body):
	if body.is_in_group("player"):
		GlobalVariables.difficulty = "H"
		finished = false
		GlobalSignal.emit_signal("start_timer")
