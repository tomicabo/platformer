extends StaticBody2D

export var speed = 30
var dead = false

func _ready():

	set_fixed_process(true)
	get_node("AnimationPlayer").play("move")

func _fixed_process(delta):
	get_parent().set_offset(get_parent().get_offset() + (speed * delta))

		
func _on_Area2D_body_enter( body ):
	if(body extends preload("res://scripts/player.gd") && dead != true && get_node("/root/globals").getPlayerFinished() != true):
		get_node("/root/globals").setPlayerDead()
		
		if get_node("/root/globals").getLives() > 1:
			get_node("/root/globals").decreaseLives()
		else:
			get_node("/root/globals").decreaseLives()
			get_node("/root/globals").setPlayerFinished()
		
		if get_node("/root/globals").getSound() != false:
			get_parent().get_parent().get_parent().get_parent().get_node("SamplePlayer").play("die")
	
		get_node("AnimationPlayer").play("free")
		
		
func set_player_alive():
	get_node("/root/globals").setPlayerAlive()
	
func anim():
	get_node("AnimationPlayer").play("move")
