extends Control

var time = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.text = "Time : " + str(time);
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Timer.text = "Time : " + str(time)


func _on_Timer2_timeout():
	time += 1
