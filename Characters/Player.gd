extends "res://Characters/Actor.gd"
class_name Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion_velocity.x = Input.get_action_strength("right_arrow") - Input.get_action_strength("left_arrow")
	motion_velocity.y = Input.get_action_strength("down_arrow") - Input.get_action_strength("up_arrow")
	motion_velocity = motion_velocity.normalized()

	if motion_velocity.length() > 0:
		$AnimationTree.set("parameters/Idle/blend_position", motion_velocity)
		$AnimationTree.set("parameters/Run/blend_position", motion_velocity)
		$AnimationTree.get("parameters/playback").travel("Run")
		motion_velocity = motion_velocity.normalized() * DEFAULT_SPEED
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
	
	move()
