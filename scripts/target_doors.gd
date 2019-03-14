
extends StaticBody2D

export var target = 1

func _ready():
	get_node("Sprite").set_offset(Vector2(0,0))
	get_node("Sprite").get_texture().set_size_override(Vector2(16,32))
	
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(target == 1):
		if(get_node("/root/globals").getTarget1State() == true):
			get_node("AnimationPlayer").play("open")
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("doors_open")
			get_node("/root/globals").setTarget1Close()
	if(target == 2):
		if(get_node("/root/globals").getTarget2State() == true):
			get_node("AnimationPlayer").play("open")
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("doors_open")
			get_node("/root/globals").setTarget2Close()
	if(target == 3):
		if(get_node("/root/globals").getTarget3State() == true):
			get_node("AnimationPlayer").play("open")
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("doors_open")
			get_node("/root/globals").setTarget3Close()