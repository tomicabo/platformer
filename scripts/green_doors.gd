
extends StaticBody2D

func _ready():
	get_node("Sprite").set_offset(Vector2(0,0))
	get_node("Sprite").get_texture().set_size_override(Vector2(16,32))


func _on_Area2D_body_enter( body ):
	if(body extends preload("res://scripts/player.gd") && get_node("/root/globals").getPlayerFinished() != true):
		if(get_node("/root/globals").getGreenKeyState() == true):
			get_node("AnimationPlayer").play("open")
			if get_node("/root/globals").getSound() != false:
				get_node("SamplePlayer").play("doors_open")
			get_node("/root/globals").setGreenKeyFalse()