extends Node2D

func _ready():

	get_node("Area2D").connect("body_enter", self, "_enter_area") #Node Connection - s kodo narejen, funkcija body_enter
	get_node("Area2D").connect("body_exit", self, "_exit_area")

func _enter_area( body ):
	if(body extends preload("res://scripts/player.gd")):
		get_node("/root/globals").setPlayerDead()
	
		if get_node("/root/globals").getLives() > 1:
			get_node("/root/globals").decreaseLives()
		else:
			get_node("/root/globals").setPlayerFinished()
		
		if get_node("/root/globals").getSound() != false:
			get_parent().get_parent().get_node("SamplePlayer").play("die")
		
func _exit_area( body ):
	if(body extends preload("res://scripts/player.gd")):
		get_node("/root/globals").setPlayerAlive()