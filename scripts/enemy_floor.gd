
extends RigidBody2D


export var bounce = 0.5

const STATE_WALKING = 0
const STATE_DYING = 1

var state = STATE_WALKING

var direction = -1
var anim=""

var rc_left=null
var rc_right=null

export var WALK_SPEED = 50

var bullet_class = preload("res://scripts/bullet.gd")
var player_class = preload("res://scripts/player.gd")

var collide=false

func _die():
	queue_free()

func _pre_explode():
	#stay there
	clear_shapes()
	set_mode(MODE_STATIC)
	get_node("sound").play("explode")


func _integrate_forces(s):


	var lv = s.get_linear_velocity()
	var new_anim=anim

	if (state==STATE_DYING):
		new_anim="die"
		
	elif (state==STATE_WALKING):
		new_anim="walk"

		var wall_side=0.0

		for i in range(s.get_contact_count()):
			var cc = s.get_contact_collider_object(i)
			var dp = s.get_contact_local_normal(i)
			
			if (cc):
			
				
				if (cc extends player_class):
					if get_owner() != null:
						if get_node("/root/globals").getLives() > 1:
							get_node("/root/globals").decreaseLives()
							get_node("/root/globals").setScene("res://scenes/level_" + str(get_node("/root/globals").getLevelNumber()) + ".scn")
						else:
							get_node("/root/globals").setScene("res://scenes/menu.scn")
					
					break
				if(cc extends bullet_class):
					#get_node("anim").play("taken")
					state=STATE_DYING
					#set_mode(MODE_KINEMATIC)
					get_node("Area2D").queue_free()
					get_node("anim").play("die")
					set_linear_velocity(Vector2 (0,0))
					set_bounce(0.5)
			
			if (dp.x>0.9):
				wall_side=1.0
			elif (dp.x<-0.9):
				wall_side=-1.0

		if (wall_side!=0 and wall_side!=direction):
			direction=-direction
			get_node("sprite").set_scale( Vector2(-direction,1) )
		if (direction<0 and not rc_left.is_colliding() and rc_right.is_colliding()):
			direction=-direction
			get_node("sprite").set_scale( Vector2(-direction,1) )
		elif (direction>0 and not rc_right.is_colliding() and rc_left.is_colliding()):
			direction=-direction
			get_node("sprite").set_scale( Vector2(-direction,1) )


		lv.x = direction * WALK_SPEED

	if( anim!=new_anim ):
		anim=new_anim
		get_node("anim").play(anim)

	s.set_linear_velocity(lv)
	
	
	#print("not shooting")
		
	#if((rc_player_notice.is_colliding() == true) and (rc_player_notice.get_collider() == player_class)):
	#print(rc_player_notice.get_collider())
	#_on_player_notice_body_enter( s )


func _ready():
	# Initalization here
	rc_left=get_node("raycast_left")
	rc_right=get_node("raycast_right")

func _on_Area2D_body_enter( body ):
	
	state=STATE_DYING
	#set_mode(MODE_KINEMATIC)
	get_node("Area2D").queue_free()
	get_node("anim").play("die")
	set_linear_velocity(Vector2 (0,0))
	set_bounce(bounce)