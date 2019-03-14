
extends CanvasLayer


func _ready():
	
	var width = get_node("/root/globals").viewport_res.x
	var height = get_node("/root/globals").viewport_res.y

	var image_width = get_node("background").get_texture().get_width()
	var image_height = get_node("background").get_texture().get_height()
	
	var level = get_node("/root/globals").getLevelNumber()
	get_node("text/congratulations").set_text(str("YOU HAVE COMPLETED LEVEL NO.", level - 1))
	
	var points = get_node("/root/globals").getCurrentScore()
	var total_points = get_node("/root/globals").getScore()
	get_node("text/score").set_text(str("SCORE: ", points))
	get_node("text/total").set_text(str("TOTAL SCORE: ", total_points))
	
	get_node("background").set_scale(Vector2(height / image_height, height / image_height))
	
	get_node("button/continue").set_pos(Vector2(width / 1.5, height / 0.8))
	get_node("button/continue").set_scale(get_node("button/continue").get_scale() / get_node("/root/globals").viewport_scale)
	
	get_node("text").set_pos(Vector2(width /2, 0))
	get_node("text").set_scale(get_node("text").get_scale() / get_node("/root/globals").viewport_scale)

func _on_continue_released():
	var level_number = get_node("/root/globals").getLevelNumber()
	get_node("/root/globals").setScene("res://scenes/level_" + str(level_number) + ".scn")
