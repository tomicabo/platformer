
extends CanvasLayer

func _ready():
	
	set_fixed_process(true)
	
	var width = get_node("/root/globals").viewport_res.x
	var height = get_node("/root/globals").viewport_res.y

	get_node("lives").set_pos(Vector2(width / 13, 0))
	get_node("lives").set_scale(get_node("lives").get_scale() / get_node("/root/globals").viewport_scale)

	get_node("score").set_pos(Vector2(width / 2.4, 0))
	get_node("score").set_scale(get_node("score").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("bullets").set_pos(Vector2(width / 1.75, 0))
	get_node("bullets").set_scale(get_node("bullets").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("key").set_pos(Vector2(width / 1.4, 0))
	get_node("key").set_scale(get_node("key").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("level").set_pos(Vector2(width / 1.18, 0))
	get_node("level").set_scale(get_node("level").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("text").set_pos(Vector2(width / 2.3, height / 1.2))
	get_node("text").set_scale(get_node("text").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("menu").set_pos(Vector2(width -21, 0))
	get_node("menu").set_scale(get_node("menu").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("popup_menu").set_pos(Vector2(width / 2 , height / 1.6))
	get_node("popup_menu").set_scale(get_node("popup_menu").get_scale() / get_node("/root/globals").viewport_scale)

func _fixed_process(delta):
	
	if (get_node("/root/globals").getBullets() == 0):
		get_node("bullets").set_opacity(0.15)
	else:
		get_node("bullets").set_opacity(1)
		
	if (get_node("/root/globals").getKeyState() == false):
		get_node("key").set_opacity(0.15)
	else:
		get_node("key").set_opacity(1)
	
	if(get_node("/root/globals").getCollidingDoors() == true):
		get_node("text/text").set_opacity(1)
	else:
		get_node("text/text").set_opacity(0)

func _on_menu_button_pressed():
	get_node("popup_menu").show()
	get_node("/root/globals").touch_inputs_hide()


func _on_resume_released():
	get_node("popup_menu").hide()
	get_node("/root/globals").touch_inputs_show()

func _on_quit_released():
	get_tree().quit()

func _on_menu_released():
	get_node("/root/globals").setScene("res://scenes/menu.scn")
