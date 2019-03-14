extends RigidBody2D

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(get_linear_velocity().y > 0):
		get_node("Sprite").set_flip_h(true)

func _on_Area2D_body_enter( body ):
	if(body extends preload("res://scripts/player.gd")):
		get_node("/root/globals").setPlayerDead()
		
		
		if get_node("/root/globals").getLives() > 1:
			get_node("/root/globals").decreaseLives()
		else:
			get_node("/root/globals").decreaseLives()
			get_node("/root/globals").setPlayerFinished()
		
		if get_node("/root/globals").getSound() != false:
			get_parent().get_parent().get_node("SamplePlayer").play("die")
	
		get_node("AnimationPlayer").play("free")
		
	else:
		queue_free()
	
func set_player_alive():
	get_node("/root/globals").setPlayerAlive()
