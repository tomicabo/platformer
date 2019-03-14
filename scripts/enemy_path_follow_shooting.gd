extends StaticBody2D

export var speed = 30
var shoot = preload("res://scenes/bat_shoot.scn")
var entered = false
export var timer = 2.5
export var shoot_speed = 200
var dead = false

func _ready():

	set_fixed_process(true)
	get_node("Timer").set_wait_time(timer)

func _fixed_process(delta):
   get_parent().set_offset(get_parent().get_offset() + (speed * delta))

func _on_Timer_timeout():
	
	if(get_node("VisibilityEnabler2D").is_on_screen() != false):
		if get_node("/root/globals").getSound() != false:
			get_node("SamplePlayer").play("bat_shoot")
			
	var bi = shoot.instance()

	bi.set_pos(get_node("Position2D").get_global_pos())
	bi.set_linear_velocity(Vector2(0,shoot_speed))
	get_tree().get_root().add_child(bi)
	
	PS2D.body_add_collision_exception(bi.get_rid(),get_rid())

func timer_queue():
	get_node("Timer").queue_free()
	
func pre_kill():
	speed = 0

func _on_Area2D_body_enter( body ):
	if(body extends preload("res://scripts/player.gd") && dead != true):
		get_node("/root/globals").setPlayerDead()
		
		if get_node("/root/globals").getLives() > 1:
			get_node("/root/globals").decreaseLives()
		else:
			get_node("/root/globals").decreaseLives()
			get_node("/root/globals").setPlayerFinished()
		
		if get_node("/root/globals").getSound() != false:
			get_parent().get_parent().get_parent().get_parent().get_node("SamplePlayer").play("die")
	
		get_node("AnimationPlayer").play("free")
		
	if(body extends preload("res://scripts/bullet.gd") && dead != true):
		get_node("AnimationPlayer").play("die")
		if get_node("/root/globals").getSound() != false:
			get_node("SamplePlayer").play("hit")
		dead = true
		
func set_player_alive():
	get_node("/root/globals").setPlayerAlive()
	get_node("AnimationPlayer").play("walk")

func anim():
	get_node("AnimationPlayer").play("walk")