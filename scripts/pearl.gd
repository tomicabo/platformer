
extends Area2D

export var value = 100
var taken=false

func _ready():
	pass

func _on_pearl_body_enter( body ):
	if (not taken and body extends preload("res://scripts/player.gd") && get_node("/root/globals").getPlayerFinished() != true):
		get_node("/root/globals").increaseCurrentScore(value)
		var print_score = get_node("/root/globals").getScore() + get_node("/root/globals").getCurrentScore()
		get_owner().get_node("stats/score/score").set_text(str("SCORE: ", print_score))
			
		get_node("Sprite/AnimationPlayer").play("collect")
		if get_node("/root/globals").getSound() != false:
			get_node("SamplePlayer").play("Pickup_Pearl")
		
		taken=true