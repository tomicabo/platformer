
extends Area2D

var taken=false

func _ready():
	pass

func _on_life_body_enter( body ):
	if (not taken and body extends preload("res://scripts/player.gd") && get_node("/root/globals").getPlayerFinished() != true):
		if (get_node("/root/globals").getLives() < 4):
			get_node("/root/globals").increaseLives()
			
			get_node("Sprite/AnimationPlayer").play("collect")
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("pickup_life")
		
			taken=true
