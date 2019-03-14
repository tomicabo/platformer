extends Node2D

var shoot = preload("res://scenes/lava_bullet_vertical.scn")
export var shoot_direction = -1
export var mirror_sprite = -1
export var timer= 1.5
export var shoot_speed = 100

func _ready():

	get_node("Area2D").connect("body_enter", self, "_enter_area") #Node Connection - s kodo narejen, funkcija body_enter
	
	if(mirror_sprite == 1):
		get_node("Sprite").set_flip_h(true)
		
	get_node("Timer").set_wait_time(timer)

func _enter_area( body ):
	if(body extends preload("res://scripts/player.gd")):
		get_node("/root/globals").setPlayerDead()
		
		
func _on_Timer_timeout():
	
	var bi = shoot.instance()
	
	if(bi.get_linear_velocity().y > 0):
		bi.get_node("Sprite").set_flip_v(true)
		
	if(get_node("VisibilityEnabler2D").is_on_screen() != false):
		if get_node("/root/globals").getSound() != false:
			get_node("SamplePlayer").play("cannon_shoot")

	var pos = get_pos() + get_node("Position2D").get_pos()*Vector2(shoot_direction,1.0)

	bi.set_pos(pos)
	get_parent().add_child(bi)

	bi.set_linear_velocity( Vector2(0,shoot_speed * -1) )
	
	
