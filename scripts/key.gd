
extends Area2D

var taken=false

func _ready():
	pass


func _on_key_body_enter( body ):
	if (not taken and body extends preload("res://scripts/player.gd") && get_node("/root/globals").getPlayerFinished() != true):
			#get_node("anim").play("taken")
			if get_owner() != null:
				get_node("/root/globals").setKeyTrue()
				
			get_node("Sprite/AnimationPlayer").play("collect")
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("Pickup_Key")
		
			taken=true