extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ExitPanel.visible = false
	GlobalSignal.connect("start_timer", self, "_start_timer")
	GlobalSignal.connect("stop_timer", self, "_stop_timer")


func _start_timer():
	GlobalVariables.stopped = false
#	GlobalVariables.can_collide = true
#	GlobalSignal.emit_signal("collider")

func _stop_timer():
	GlobalVariables.stopped = true
	print(GlobalVariables.time)
#	GlobalVariables.can_collide = false
#	GlobalSignal.emit_signal("collider")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if GlobalVariables.stopped:
#		GlobalVariables.time = 0 
#	else:
	$Time.text = "Time : " + $Stopwatch.time_to_string()
	if GlobalVariables.show_exitpanal:
		$ExitPanel.visible = true
	else:
		$ExitPanel.visible = false
	
#func _on_Timer2_timeout():
#	GlobalVariables.time += 1

#
#func _on_Timer_timeout():
#	GlobalVariables.time += 1


func _on_MenuButton_pressed():
	$MenuButton.play()
	yield($MenuButton,"finished")
	get_tree().change_scene("res://scenes/Menu.tscn")
	GlobalVariables.show_exitpanal = false
	_stop_timer()
	GlobalVariables.time = 0.0





