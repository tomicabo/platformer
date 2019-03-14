
extends CanvasLayer



func _ready():

	set_fixed_process(true)
	
	get_node("left_inputs").set_pos(Vector2(0, get_node("/root/globals").viewport_res.y))
	get_node("left_inputs").set_scale(get_node("left_inputs").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("right_inputs").set_pos(get_node("/root/globals").viewport_res)
	get_node("right_inputs").set_scale(get_node("right_inputs").get_scale() / get_node("/root/globals").viewport_scale)
		
	get_node("left_inputs1").set_pos(Vector2(0, get_node("/root/globals").viewport_res.y))
	get_node("left_inputs1").set_scale(get_node("left_inputs1").get_scale() / get_node("/root/globals").viewport_scale)
		
	get_node("right_inputs1").set_pos(get_node("/root/globals").viewport_res)
	get_node("right_inputs1").set_scale(get_node("right_inputs1").get_scale() / get_node("/root/globals").viewport_scale)
	

func _fixed_process(delta):
	
	if (get_node("/root/globals").touch_inputs_visible() == false):
		get_node("left_inputs").hide()
		get_node("left_inputs/left").set_action("")
		get_node("left_inputs/right").set_action("")
		
		get_node("right_inputs").hide()
		get_node("right_inputs/jump").set_action("")
		get_node("right_inputs/shoot").set_action("")
		
		get_node("left_inputs1").hide()
		get_node("left_inputs1/jump").set_action("")
		get_node("left_inputs1/left").set_action("")
		get_node("left_inputs1/shoot").set_action("")
		
		get_node("right_inputs1").hide()
		get_node("right_inputs1/jump").set_action("")
		get_node("right_inputs1/right").set_action("")
		get_node("right_inputs1/shoot").set_action("")

	else:
		get_node("left_inputs").show()
		get_node("left_inputs/left").set_action("btn_left")
		get_node("left_inputs/right").set_action("btn_right")
		
		get_node("right_inputs").show()
		get_node("right_inputs/jump").set_action("btn_jump")
		get_node("right_inputs/shoot").set_action("btn_shoot")
		
		get_node("left_inputs1").show()
		get_node("left_inputs1/jump").set_action("btn_jump")
		get_node("left_inputs1/left").set_action("btn_left")
		get_node("left_inputs1/shoot").set_action("btn_shoot")
		
		get_node("right_inputs1").show()
		get_node("right_inputs1/jump").set_action("btn_jump")
		get_node("right_inputs1/right").set_action("btn_right")
		get_node("right_inputs1/shoot").set_action("btn_shoot")
		
	if(get_node("/root/globals").getTouchInputMode() == false and get_node("/root/globals").touch_inputs_visible() == true):
		get_node("left_inputs1").hide()
		get_node("left_inputs1/jump").set_action("")
		get_node("left_inputs1/left").set_action("")
		get_node("left_inputs1/shoot").set_action("")
		
		get_node("right_inputs1").hide()
		get_node("right_inputs1/jump").set_action("")
		get_node("right_inputs1/right").set_action("")
		get_node("right_inputs1/shoot").set_action("")
		
		get_node("left_inputs").show()
		get_node("left_inputs/left").set_action("btn_left")
		get_node("left_inputs/right").set_action("btn_right")
		
		get_node("right_inputs").show()
		get_node("right_inputs/jump").set_action("btn_jump")
		get_node("right_inputs/shoot").set_action("btn_shoot")
		
	if(get_node("/root/globals").getTouchInputMode() == true and get_node("/root/globals").touch_inputs_visible() == true):
		get_node("left_inputs").hide()
		get_node("left_inputs/left").set_action("")
		get_node("left_inputs/right").set_action("")
		
		get_node("right_inputs").hide()
		get_node("right_inputs/jump").set_action("")
		get_node("right_inputs/shoot").set_action("")
		
		get_node("left_inputs1").show()
		get_node("left_inputs1/jump").set_action("btn_jump")
		get_node("left_inputs1/left").set_action("btn_left")
		get_node("left_inputs1/shoot").set_action("btn_shoot")
		
		get_node("right_inputs1").show()
		get_node("right_inputs1/jump").set_action("btn_jump")
		get_node("right_inputs1/right").set_action("btn_right")
		get_node("right_inputs1/shoot").set_action("btn_shoot")
