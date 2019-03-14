
extends StaticBody2D

var shoot = preload("res://scenes/lava_bullet.scn")
export var shoot_direction = -1
export var mirror_sprite = -1
export var timer= 1.5
export var shoot_speed = 320

func _ready():
	
	if(mirror_sprite == 1):
		get_node("Sprite").set_flip_h(true)
		
	get_node("Timer").set_wait_time(timer)


func _on_Timer_timeout():
	
	var bi = shoot.instance()
	
	if(mirror_sprite == 1):
		bi.get_node("Sprite").set_flip_h(true)
		
	if(get_node("VisibilityEnabler2D").is_on_screen() != false):
		if get_node("/root/globals").getSound() != false:
			get_node("SamplePlayer").play("cannon_shoot")

	var pos = get_pos() + get_node("Position2D").get_pos()*Vector2(shoot_direction,1.0)

	bi.set_pos(pos)
	get_parent().add_child(bi)

	bi.set_linear_velocity( Vector2(shoot_speed*(shoot_direction),0) )
