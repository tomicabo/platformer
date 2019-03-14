extends Node

#variables
var viewport_scale
var viewport_res

var currentScene = null

var level_number = 1
var lives = 3

var bullets = 0
var temp_bullets = 0

var key = false
var red_key = false
var blue_key = false
var green_key = false

var doors = false

var touch_inputs = true
var touch_input_mode = false

var player_move = true

var score = 0
var current_score = 0

var music = false
var sound = true

var player_dead = false

var player_finished = false

var player_entering_doors = false

var player_falling

var target1 = false
var target2 = false
var target3 = false

#functions
func getLevelNumber():
	return level_number

func increaseLevelNumber():
	level_number = level_number + 1

func resetLevelNumber():
	level_number = 1

func getLives():
	return lives

func decreaseLives():
	lives = lives - 1

func increaseLives():
	lives = lives + 1

func resetLives():
	lives = 3

func getBullets():
	return bullets

func increaseBullets(bullet_increased):
	bullets = bullets + bullet_increased

func decreaseBullet():
	bullets = bullets - 1

func resetTempBullets():
	temp_bullets = 0

func getTempBullets():
	return temp_bullets

func increaseTempBullets(bullet_increased):
	temp_bullets = temp_bullets + bullet_increased

func decreaseTempBullet():
	temp_bullets = temp_bullets - 1

func resetBullets():
	bullets = bullets - temp_bullets

func resetBulletsZero():
	bullets = 0

func setKeyTrue():
	key = true

func setKeyFalse():
	key = false

func getKeyState():
	return key

func setRedKeyTrue():
	red_key = true

func setRedKeyFalse():
	red_key = false

func getRedKeyState():
	return red_key

func setBlueKeyTrue():
	blue_key = true

func setBlueKeyFalse():
	blue_key = false

func getBlueKeyState():
	return blue_key

func setGreenKeyTrue():
	green_key = true

func setGreenKeyFalse():
	green_key = false

func getGreenKeyState():
	return green_key

func setIsCollidingDoors():
	doors = true

func setIsNotCollidingDoors():
	doors = false

func getCollidingDoors():
	return doors

func touch_inputs_visible():
	return touch_inputs

func touch_inputs_show():
	touch_inputs = true

func touch_inputs_hide():
	touch_inputs = false

func getTouchInputMode():
	return touch_input_mode

func setTouchInputMode2():
	touch_input_mode = true

func setTouchInputMode1():
	touch_input_mode = false

func increaseScore(scr):
	score = score + scr

func getScore():
	return score

func resetScore():
	score = 0

func increaseCurrentScore(scr):
	current_score = current_score + scr

func getCurrentScore():
	return current_score

func resetCurrentScore():
	current_score = 0

func setMusicOn():
	music = true

func setMusicOff():
	music = false

func getMusic():
	return music

func setSoundOn():
	sound = true

func setSoundOff():
	sound = false

func getSound():
	return sound

func setPlayerDead():
	player_dead = true

func setPlayerAlive():
	player_dead = false

func getPlayerDead():
	return player_dead

func setPlayerFinished():
	player_finished = true

func setPlayerNotFinished():
	player_finished = false

func getPlayerFinished():
	return player_finished

func setPlayerEnteringDoors():
	player_entering_doors = true

func setPlayerNotEnteringDoors():
	player_entering_doors = false

func getPlayerEnteringDoors():
	return player_entering_doors

func getPlayerFalling():
	return player_falling

func setPlayerFalling():
	player_falling = true

func setPlayerNotFalling():
	player_falling = false

func setTarget1Open():
	target1 = true
func setTarget2Open():
	target2 = true
func setTarget3Open():
	target3 = true

func setTarget1Close():
	target1 = false
func setTarget2Close():
	target2 = false
func setTarget3Close():
	target3 = false

func getTarget1State():
	return target1
func getTarget2State():
	return target2
func getTarget3State():
	return target3

func enemykill10():
	score = score + 10

func _ready():
	var viewport = get_node("/root").get_children()[1].get_viewport_rect().size
	viewport_res = get_node("/root").get_children()[1].get_viewport_rect().size
	viewport_scale = 180/viewport.y
	print(get_node("/root").get_children()[1].get_viewport_rect().size)
	print(180/viewport.y)
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1)

func setScene(scene):

	call_deferred("_deferred_goto_scene", scene)

func _deferred_goto_scene(scene):
	var s = ResourceLoader.load(scene)
	currentScene.queue_free()
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
	get_tree().set_current_scene(currentScene)
