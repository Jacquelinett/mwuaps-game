extends Area2D

var body_list: Array[Actor] = []
var sprites: Array[Sprite2D] = []
var last_frame: Array[int] = [] # Used for optimization
	
func set_opposite_frame(sprite, frame):
	# Is this best approach? No, BUT
	# I considered using AnimationPlayer but the issue is
	# Since this run every loop it would replay the animation
	# Over and over again instead of letting it match up
	if frame == 6 || frame == 0:
		sprite.frame = 6 - frame
		sprite.flip_h = true
	elif frame == 1 || frame == 7:
		sprite.frame = 8 - frame
		sprite.flip_h = true
	elif frame == 2 || frame == 8:
		sprite.frame = 10 - frame
		sprite.flip_h = true
	elif frame == 3 || frame == 9:
		sprite.frame = 12 - frame
		sprite.flip_h = false
	elif frame == 4 || frame == 10:
		sprite.frame = 14 - frame
		sprite.flip_h = true
	elif frame == 5 || frame == 11:
		sprite.frame = 16 - frame
		sprite.flip_h = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for index in len(body_list):
		var body = body_list[index]
		var frame = body.get_node("Sprite").frame
		if last_frame[index] != frame:
			var new_x = body.position.x - position.x
			var sprite = sprites[index]
			sprite.position.x = new_x
			set_opposite_frame(sprite, frame)
			last_frame[index] = frame

func _on_mirror_body_entered(body: Actor):
	if !body: return
	if !body_list.has(body):
		body_list.append(body)
		var reflection = Sprite2D.new()
		var sprite = body.get_node("Sprite")
		reflection.texture = sprite.texture
		reflection.vframes = sprite.vframes
		reflection.hframes = sprite.hframes
		set_opposite_frame(reflection, sprite.frame)
		sprites.append(reflection)
		add_child(reflection)
		last_frame.append(reflection.frame)
		print("Inserted ", body.name, " into the mirror body array")
	else:
		print("Body entered but already exist")


func _on_mirror_body_exited(body):
	if body_list.has(body):
		var index = body_list.find(body)
		body_list.remove_at(index)
		remove_child(sprites[index])
		sprites.remove_at(index)
		last_frame.remove_at(index)
		print("Removed ", body.name, " into the mirror body array")
	else:
		print("Body exit but not there")
