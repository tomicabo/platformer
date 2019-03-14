
extends Area2D

var entered=false

func _ready():
	pass

func _on_doors_body_enter( body ):
	if(not entered and body extends preload("res://scripts/player.gd") && get_node("/root/globals").getPlayerFinished() != true):
		if(get_node("/root/globals").getKeyState() == true):
			get_node("/root/globals").setPlayerEnteringDoors()
			get_node("Sprite/AnimationPlayer").play("enter")
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("next_level")
			entered = true
		else:
			get_node("/root/globals").setIsCollidingDoors()


func _on_doors_body_exit( body ):
	get_node("/root/globals").setIsNotCollidingDoors()

#	get_node("/root/globals").setCurrentScore(get_owner().points_collected)
#	get_node("/root/globals").increaseScore(get_owner().points_collected)
#	get_node("/root/globals").setScene("res://scenes/level_complete.scn")