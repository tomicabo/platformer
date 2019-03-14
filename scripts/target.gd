
extends StaticBody2D

export var target = 1
export var speed = 50

func _ready():
	get_node("/root/globals").setTarget1Close()
	get_node("/root/globals").setTarget2Close()
	get_node("/root/globals").setTarget3Close()

	set_fixed_process(true)
	
func _fixed_process(delta):
	get_parent().set_offset(get_parent().get_offset() + (speed * delta))

func _on_Area2D_body_enter( body ):
	if(body extends preload("res://scripts/bullet.gd")):
		
		#get_node("AnimationPlayer").play("hit")
		
		get_node("Sprite").set_texture(load("res://textures/target_pressed.tex"))
		
		if get_node("/root/globals").getSound() != false:
			get_node("SamplePlayer").play("hit")
	
		if(target == 1):
			get_node("/root/globals").setTarget1Open()
		elif(target == 2):
			get_node("/root/globals").setTarget2Open()
		elif(target==3):
			get_node("/root/globals").setTarget3Open()
	
