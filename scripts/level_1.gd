
extends Node2D

var res = null

func _ready():

	var total_score = get_node("/root/globals").getScore()
	get_node("stats/score/score").set_text(str("SCORE: ", total_score))

	set_fixed_process(true)
	
	var level = get_node("/root/globals").getLevelNumber()
	get_node("stats/level/level").set_text(str("LEVEL: ", level))
	
	get_node("/root/globals").resetTempBullets()
	get_node("/root/globals").resetBullets()
	get_node("stats/bullets/ammo").set_text(str(get_node("/root/globals").getBullets()))
	
	
	
	
	get_node("/root/globals").setPlayerNotFinished()
	get_node("/root/globals").setPlayerAlive()
	get_node("/root/globals").setPlayerNotEnteringDoors()
	get_node("/root/globals").setKeyFalse()
	get_node("/root/globals").resetCurrentScore()
	

func _fixed_process(delta):
	var lives = get_node("/root/globals").getLives()
	if(lives == 0):
		res = null
	if(lives == 1):
		res = load("res://textures/1life.tex")
	elif(lives == 2):
		res = load("res://textures/2lives.tex")
	elif(lives == 3):
		res = load("res://textures/3lives.tex")
	elif(lives == 4):
		res = load("res://textures/4lives.tex")
	get_node("stats/lives/lives_texture").set_texture(res)