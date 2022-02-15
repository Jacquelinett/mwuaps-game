extends CharacterBody2D
class_name Actor

const DEFAULT_SPEED = 150

@export var character_name : String
@export var dialog_id : int

func init(cname, d_id):
	character_name = cname
	dialog_id = d_id

func _ready():
	set_physics_process(true)
	
func move():
	if motion_velocity != Vector2.ZERO:
		move_and_slide()

func _process(delta):
	pass
		
