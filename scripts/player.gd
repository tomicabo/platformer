
extends RigidBody2D

var input_states = preload("res://scripts/input_states.gd")

export var player_speed = 100
export var extra_gravity = 490
export var jumpforce = 220

var PLAYERSTATE_PREV = ""
var PLAYERSTATE = ""
var PLAYERSTATE_NEXT = "ground"

var ORIENTATION_PREV = ""
var ORIENTATION = ""
var ORIENTATION_NEXT = "start"

var current_speed = Vector2(0,0)

var raycast_down = null
var raycast_down2 = null

var rotate = null

var jumping = 0

var anim_player = null
var anim = ""
var anim_new =""
var anim_speed = 1.0
var anim_blend = 0.2

var shooting = false
var remember_anim = ""

var bullet = preload("res://scenes/bullet.scn")

var btn_right = input_states.new("btn_right")
var btn_left = input_states.new("btn_left")
var btn_jump = input_states.new("btn_jump")
var btn_shoot = input_states.new("btn_shoot")

func move(speed, delta):
	current_speed.x = lerp(current_speed.x, speed, 1)
	set_linear_velocity(Vector2(current_speed.x,get_linear_velocity().y))

func is_on_ground():
	if raycast_down.is_colliding() or raycast_down2.is_colliding():
		return true
	else:
		return false

func _ready():
	# Initalization here
	get_node("Camera2D").set_zoom(get_node("Camera2D").get_zoom() * get_node("/root/globals").viewport_scale)

	set_fixed_process(true)
	set_applied_force(Vector2(0,extra_gravity))

	raycast_down = get_node("RayCast2D")
	raycast_down2 = get_node("RayCast2D1")
	raycast_down.add_exception(self)
	raycast_down2.add_exception(self)

	rotate = get_node("rotate")

	anim_player = get_node("rotate/player_sprite/AnimationPlayer")

	Input.action_release("btn_right")
	Input.action_release("btn_left")
	Input.action_release("btn_jump")
	Input.action_release("btn_shoot")

	#touch screen kontrole pozicija
#	get_node("CanvasLayer").get_node("left_inputs").set_pos(Vector2(0, get_node("/root/globals").viewport_res.y))
#	get_node("CanvasLayer").get_node("left_inputs").set_scale(get_node("CanvasLayer").get_node("left_inputs").get_scale() / get_node("/root/globals").viewport_scale)
#
#	get_node("CanvasLayer").get_node("right_inputs").set_pos(get_node("/root/globals").viewport_res)
#	get_node("CanvasLayer").get_node("right_inputs").set_scale(get_node("CanvasLayer").get_node("right_inputs").get_scale() / get_node("/root/globals").viewport_scale)

func rotate_behavior():
	if (ORIENTATION == "right" and ORIENTATION_NEXT == "left") or (ORIENTATION == "left" and ORIENTATION_NEXT == "right") or (ORIENTATION == "start" and ORIENTATION_NEXT == "left"):
		rotate.set_scale(rotate.get_scale() * Vector2(-1,1))

func _fixed_process(delta):

	PLAYERSTATE_PREV = PLAYERSTATE
	PLAYERSTATE = PLAYERSTATE_NEXT

	ORIENTATION_PREV = ORIENTATION
	ORIENTATION = ORIENTATION_NEXT

	if PLAYERSTATE == "ground" && get_node("/root/globals").getPlayerEnteringDoors() != true && get_node("/root/globals").getPlayerDead() != true && get_node("/root/globals").getPlayerFinished() != true:
		ground_state(delta)
		get_node("rotate/player_sprite").set_modulate("#FFFFFF")
	if PLAYERSTATE == "air" && get_node("/root/globals").getPlayerEnteringDoors() != true && get_node("/root/globals").getPlayerDead() != true && get_node("/root/globals").getPlayerFinished() != true:
		air_state(delta)
		get_node("rotate/player_sprite").set_modulate("#FFFFFF")

	if get_node("/root/globals").getPlayerDead() == true && get_node("/root/globals").getPlayerFinished() != true:
		ground_state(delta)
		get_node("rotate/player_sprite").set_modulate("#FF0000")

	if anim != anim_new:
		anim_new = anim
		anim_player.play(anim, anim_blend, anim_speed)


	if get_node("/root/globals").getPlayerEnteringDoors() == true:
		move(0,0)
		anim = "enter_doors"

	if get_node("/root/globals").getPlayerFinished() == true:
		move(0,0)
		get_node("rotate/player_sprite").set_modulate("#FF0000")
		anim = "dead"

	get_node("Camera2D/Label").set_text(str(OS.get_frames_per_second()))

func ground_state(delta):

	if Input.is_action_pressed("btn_left"):
		move(-player_speed, delta)
		ORIENTATION_NEXT = "left"
		anim = "walk"
		anim_speed = 2.0
#		anim_blend = 50.0

	elif Input.is_action_pressed("btn_right"):
		move(player_speed,  delta)
		ORIENTATION_NEXT = "right"
		anim = "walk"
		anim_speed = 2.0

	else:
		move(0, delta)
		anim = "idle"
		anim_speed = 1

	rotate_behavior()

	if is_on_ground():
		if btn_jump.check() == 1:
			set_axis_velocity(Vector2(0, -jumpforce))
			jumping = 1
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("Jump")
	else:
		PLAYERSTATE_NEXT = "air"

	if (btn_shoot.check() == 1 and not shooting and get_node("/root/globals").getBullets() > 0):
		get_node("/root/globals").decreaseBullet()
		get_node("/root/globals").decreaseTempBullet()
		shoot()
		remember_anim = anim

func air_state(delta):

	if Input.is_action_pressed("btn_left"):
		move(-player_speed,  delta)
		ORIENTATION_NEXT = "left"
		anim = "jump"
		anim_speed = 1.0
	elif Input.is_action_pressed("btn_right"):
		move(player_speed,  delta)
		ORIENTATION_NEXT = "right"
		anim = "jump"
		anim_speed = 1.0
	else:
		move(0, delta)
		anim = "idle"

	rotate_behavior()

	if is_on_ground():
		PLAYERSTATE_NEXT = "ground"

	if (btn_shoot.check() == 1 and not shooting and get_node("/root/globals").getBullets() > 0):
		get_node("/root/globals").decreaseBullet()
		get_node("/root/globals").decreaseTempBullet()
		shoot()
		remember_anim = anim

	if(get_linear_velocity().y > 0 && get_linear_velocity().y != 164):
		get_node("/root/globals").setPlayerFalling()
	else:
		get_node("/root/globals").setPlayerNotFalling()

	#fixed bug - ččce player skoci na platformo visoko 16px, se zgodi da ostane y na 164
	if(int(get_linear_velocity().y) == 164):
		get_node("/root/globals").setPlayerNotFalling()


func shoot():

	anim_player.play("shoot", 0, 3)
	if get_node("/root/globals").getSound() != false:
		get_node("SamplePlayer").play("Shoot")

	var bi = bullet.instance()
	var ss
	if (ORIENTATION == "left"):
		ss=-1
		bi.rotate(3.14159)
	else:
		ss=1
	var pos = get_pos() + get_node("shoot_pos").get_pos()*Vector2(ss,0)


	bi.set_pos(pos)
	get_parent().add_child(bi)

	bi.set_linear_velocity( Vector2(150.0*ss,0) )

	PS2D.body_add_collision_exception(bi.get_rid(),get_rid()) # make bullet and this not collide

	get_owner().get_node("stats/bullets/ammo").set_text(str(get_node("/root/globals").getBullets()))


func reset_animation():
	anim = remember_anim
	anim_player.play(anim, 0, 2)

func dead():
	get_node("/root/globals").setScene("res://scenes/died.scn")

func entering_doors():
	get_node("/root/globals").increaseLevelNumber()

	get_node("/root/globals").increaseScore(get_node("/root/globals").getCurrentScore())
	var level_number = get_node("/root/globals").getLevelNumber()
	if(level_number < 6):
		get_node("/root/globals").setScene("res://scenes/level_complete.scn")
	else:
		get_node("/root/globals").setScene("res://scenes/menu.scn")
