extends Control
class_name Stopwatch

#var time = 0.0

func _process(delta):
	if GlobalVariables.stopped:
		return
	GlobalVariables.time += delta

func reset():
	GlobalVariables.time = 0.0

func time_to_string():
	var msec = fmod(GlobalVariables.time, 1) * 100
	var sec = fmod(GlobalVariables.time, 60)
	var mint = GlobalVariables.time / 60
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [mint, sec, msec]
	return actual_string

