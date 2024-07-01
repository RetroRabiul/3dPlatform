extends MeshInstance

var open_door = false

#onready var anim = $"%DoorAnim"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		if open_door == false :
			$"%DoorAnim".play("Open")
#			var tween = create_tween()
#			tween.tween_property($"%DoorAnim", "current_animation","Open",0)
#			yield($"%DoorAnim", "finished")
			open_door = true


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		if open_door == true:
			$"%DoorAnim".play("Close")
#			var tween2 = create_tween()
#			tween2.tween_property($"%DoorAnim", "current_animation","Close")
#			yield($"%DoorAnim", "finished")
			open_door = false

#	var tween = create_tween()
#	tween.tween_property($CPUParticles2D, "modulate:a", 0.0, 1.0)
#	yield(tween, "finished")
#	visible = false



