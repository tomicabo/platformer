
extends Area2D

export var value = 1
var taken=false

func _ready():
	pass

func _on_bullets_body_enter( body ):
	if (not taken and body extends preload("res://scripts/player.gd") && get_node("/root/globals").getPlayerFinished() != true):
			#get_node("anim").play("taken")
			if get_owner() != null:
				get_node("/root/globals").increaseBullets(value)
				get_node("/root/globals").increaseTempBullets(value)
				get_owner().get_node("stats/bullets/ammo").set_text(str(get_node("/root/globals").getBullets()))
				
			get_node("Sprite/AnimationPlayer").play("collect")
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("Pickup_Bullets")

			taken=true