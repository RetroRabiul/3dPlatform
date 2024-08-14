extends Control


var score: int = 33
export var player_name: String

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#
#onready var audio = $ButtonAudio

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	if Input.is_action_just_pressed("add-score"):
		
		SilentWolf.Scores.wipe_leaderboard()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _add_score():
	player_name = $NameDialog/NameInput.text
	print("CALLED ADD SCORE")
	score += 8
	SilentWolf.Scores.persist_score(player_name,score)


func _on_Play_pressed():
	$ButtonAudio.play()
	yield($ButtonAudio,"finished")
	$NeedName.visible = false
	GlobalVariables.player_name = $NameDialog/NameInput.text.strip_edges()
	if GlobalVariables.player_name == "":
		print("need a name")
		$NeedName.visible = true
		return
	get_tree().change_scene("res://scenes/world.tscn")


func _on_Scores_pressed():
	$ButtonAudio.play()
	yield($ButtonAudio,"finished")
	call_deferred("_Change_scene")
#	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
#	print("Scores: " + str(SilentWolf.Scores.scores))
	
func _Change_scene():
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
	

