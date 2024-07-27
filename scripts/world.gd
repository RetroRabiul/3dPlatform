extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"%EndSlideCollision".disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://scenes/world.tscn")
		GlobalVariables.time = 0
		GlobalVariables.stopped = true
		GlobalVariables.can_collide = false


func _on_Timer_Starts_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("start_timer")


func _on_WinningArea_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("stop_timer")
		$"%EndSlideCollision".disabled = true


func _on_StopSlide_body_exited(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("reset")
		$"%EndSlideCollision".disabled = false
	


func _on_SlideArea_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignal.emit_signal("start_sliding")
