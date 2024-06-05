extends Control

var time = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignal.connect("start_timer", self, "_start_timer")


func _start_timer():
	$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Time.text = "Time : " + str(GlobalVariables.time)


func _on_Timer2_timeout():
	GlobalVariables.time += 1
