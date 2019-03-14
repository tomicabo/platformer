
extends Node2D


func _ready():
	
	var width = get_node("/root/globals").viewport_res.x
	var height = get_node("/root/globals").viewport_res.y

	var image_width = get_node("background").get_texture().get_width()
	var image_height = get_node("background").get_texture().get_height()
	
	get_node("background").set_scale(Vector2(height / image_height, height / image_height))
	
	get_node("buttons/play").set_pos(Vector2(width / 1.5, height / 1.12))
	get_node("buttons/play").set_scale(get_node("buttons/play").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("buttons/options").set_pos(Vector2(width / 1.5, height / 0.9))
	get_node("buttons/options").set_scale(get_node("buttons/options").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("buttons/quit").set_pos(Vector2(width / 1.5, height / 0.75))
	get_node("buttons/quit").set_scale(get_node("buttons/quit").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("text").set_pos(Vector2(width / 1, height / 1.2))
	get_node("text").set_scale(get_node("text").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("logo").set_pos(Vector2(width / 400, height / 1.2))
	get_node("logo").set_scale(get_node("logo").get_scale() / get_node("/root/globals").viewport_scale)

func _on_play_released():
	get_node("/root/globals").setScene("res://scenes/level_1.scn")
	get_node("/root/globals").resetLives()
	get_node("/root/globals").resetLevelNumber()
	get_node("/root/globals").touch_inputs_show()
	get_node("/root/globals").resetBullets()
	get_node("/root/globals").resetTempBullets()
	get_node("/root/globals").resetBulletsZero()
	get_node("/root/globals").resetCurrentScore()
	get_node("/root/globals").resetScore()
	
	

func _on_quit_released():
	get_tree().quit()


func _on_options_released():
	get_node("/root/globals").setScene("res://scenes/options_menu.scn")


func _on_play_pressed():
	if get_node("/root/globals").getSound() != false:
		get_node("SamplePlayer").play("button")


func _on_options_pressed():
	if get_node("/root/globals").getSound() != false:
		get_node("SamplePlayer").play("button")


func _on_quit_pressed():
	if get_node("/root/globals").getSound() != false:
		get_node("SamplePlayer").play("button")
