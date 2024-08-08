extends Node

func _ready():
	SilentWolf.configure({
		"api_key": "hL1Wngg4gG25pKqzs0kHk5grIFiPMtbp2azNLvnE",
		"game_id": "StarrySlide",
		"game_version": "0.2.0",
		"log_level": 1
		})

	SilentWolf.configure_scores({
		"open_scene_on_close": "res://scenes/Splash.tscn"
		})
 


signal start_timer()

signal stop_timer()

signal start_sliding()
signal reset()

signal collider()
