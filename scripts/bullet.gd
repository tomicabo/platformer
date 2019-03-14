
extends RigidBody2D

var disabled=false

func _ready():
	pass

#func disable():
#	if (disabled):
#		return
#	disabled=true

func _on_Area2D_body_enter( body ):
		queue_free()
