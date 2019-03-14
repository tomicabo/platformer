
extends Control


func _ready():
	
	var width = get_node("/root/globals").viewport_res.x
	var height = get_node("/root/globals").viewport_res.y

	var image_width = get_node("background").get_texture().get_width()
	var image_height = get_node("background").get_texture().get_height()
	
	get_node("background").set_scale(Vector2(height / image_height, height / image_height))
	
	get_node("buttons/back").set_pos(Vector2(width / 1.5, height / 0.75))
	get_node("buttons/back").set_scale(get_node("buttons/back").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("buttons/touch_input_toggle").set_pos(Vector2(width / 6, height / 0.9))
	get_node("buttons/touch_input_toggle").set_scale(get_node("buttons/touch_input_toggle").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("buttons/sounds_toggle").set_pos(Vector2(width / 0.85, height / 0.9))
	get_node("buttons/sounds_toggle").set_scale(get_node("buttons/sounds_toggle").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("buttons/music_toggle").set_pos(Vector2(width / 0.85, height / 0.9))
	get_node("buttons/music_toggle").set_scale(get_node("buttons/music_toggle").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("touch_input").set_pos(Vector2(width / 20, height / 3.4))
	get_node("touch_input").set_scale(get_node("touch_input").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("sound").set_pos(Vector2(width / 1.23, height / 1.9))
	get_node("sound").set_scale(get_node("sound").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("music").set_pos(Vector2(width / 1.23, height / 1.9))
	get_node("music").set_scale(get_node("music").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("menu_title").set_pos(Vector2(width / 2, 0))
	get_node("menu_title").set_scale(get_node("menu_title").get_scale() / get_node("/root/globals").viewport_scale)

	var  touch_mode = get_node("/root/globals").getTouchInputMode()

	if(touch_mode == true):
		get_node("touch_input").set_texture(load("res://textures/touch_inputs2.tex"))
	elif(touch_mode == false):
		get_node("touch_input").set_texture(load("res://textures/touch_inputs1.tex"))
		
	var sound = get_node("/root/globals").getSound()
	
	if(sound == true):
		get_node("sound").set_texture(load("res://textures/sound_on.tex"))
	elif(sound == false):
		get_node("sound").set_texture(load("res://textures/sound_off.tex"))
		
	var music = get_node("/root/globals").getMusic()
	
	if(music == true):
		get_node("music").set_texture(load("res://textures/music_on.tex"))
	elif(music == false):
		get_node("music").set_texture(load("res://textures/music_off.tex"))

func _on_back_released():
	get_node("/root/globals").setScene("res://scenes/menu.scn")


func _on_touch_input_toggle_released():
	
	var  touch_mode = get_node("/root/globals").getTouchInputMode()
	
	if(touch_mode == false):
		get_node("/root/globals").setTouchInputMode2()
		get_node("touch_input").set_texture(load("res://textures/touch_inputs2.tex"))
	elif(touch_mode == true):
		get_node("/root/globals").setTouchInputMode1()
		get_node("touch_input").set_texture(load("res://textures/touch_inputs1.tex"))


func _on_sounds_toggle_released():
	
	var sound = get_node("/root/globals").getSound()
	
	if(sound == true):
		get_node("/root/globals").setSoundOff()
		get_node("sound").set_texture(load("res://textures/sound_off.tex"))
	elif(sound == false):
		get_node("/root/globals").setSoundOn()
		get_node("sound").set_texture(load("res://textures/sound_on.tex"))


func _on_music_toggle_released():
	
	var music = get_node("/root/globals").getMusic()
	
	if(music == true):
		get_node("/root/globals").setMusicOff()
		get_node("music").set_texture(load("res://textures/music_off.tex"))
	elif(music == false):
		get_node("/root/globals").setMusicOn()
		get_node("music").set_texture(load("res://textures/music_on.tex"))


func _on_back_pressed():
	if get_node("/root/globals").getSound() != false:
		get_node("SamplePlayer").play("button")


func _on_touch_input_toggle_pressed():
	if get_node("/root/globals").getSound() != false:
		get_node("SamplePlayer").play("button")


func _on_sounds_toggle_pressed():
	if get_node("/root/globals").getSound() != false:
		get_node("SamplePlayer").play("button")
