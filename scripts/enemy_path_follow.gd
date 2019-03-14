extends StaticBody2D

export var speed = 20
var dead = false

func _ready():

	set_fixed_process(true)

func _fixed_process(delta):
	get_parent().set_offset(get_parent().get_offset() + (speed * delta))

#func _on_Area2D_kill_body_enter( body ):
#	if(body extends preload("res://scripts/player.gd") && dead != true && get_node("/root/globals").getPlayerFinished() != true):
#		if(get_node("/root/globals").getPlayerFalling() == true):
#			get_node("AnimationPlayer").play("die")
#			if get_node("/root/globals").getSound() != false:
#				get_node("SamplePlayer").play("hit")
#			dead = true
#
#	if(body extends preload("res://scripts/bullet.gd") && dead != true):
#		if get_node("/root/globals").getSound() != false:
#			get_node("SamplePlayer").play("hit")
#		get_node("AnimationPlayer").play("die")
#		dead = true

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

	if(body extends preload("res://scripts/bullet.gd") && dead != true):
		if get_node("/root/globals").getSound() != false:
			get_node("SamplePlayer").play("hit")
		get_node("AnimationPlayer").play("die")

		get_node("/root/globals").increaseCurrentScore(10)
		var print_score = get_node("/root/globals").getScore() + get_node("/root/globals").getCurrentScore()
		get_owner().get_owner().get_node("stats/score/score").set_text(str("SCORE: ", print_score))
		dead = true


func pre_die():
	speed = 0

func set_player_alive():
	get_node("/root/globals").setPlayerAlive()

func anim():
	get_node("AnimationPlayer").play("walk")


func _on_Area2D_body_exit( body ):
	get_node("CollisionShape2D").queue_free()
