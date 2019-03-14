extends RigidBody2D

export var anim = 1

func _ready():

	set_fixed_process(true)
	
	if(anim == 1):
		get_node("AnimationPlayer").play("New Anim")
	elif(anim == 2):
		get_node("AnimationPlayer").play("New Anim (copy)")

func _fixed_process(delta):
   pass

func _on_Area2D_body_enter( body ):
	if(body extends preload("res://scripts/player.gd")):
		get_node("/root/globals").setPlayerDead()
	
		if get_node("/root/globals").getLives() > 1:
			get_node("/root/globals").decreaseLives()
		else:
			get_node("/root/globals").setPlayerFinished()
		
		if get_node("/root/globals").getSound() != false:
			get_parent().get_parent().get_node("SamplePlayer").play("die")
		
func play_sound():
	if(get_node("VisibilityEnabler2D").is_on_screen() != false):
		if get_node("/root/globals").getSound() != false:
			get_node("SamplePlayer").play("crasher")
	