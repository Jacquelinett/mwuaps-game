extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hidable_wall_body_entered(body: Player):
	if !body: return
	modulate.a = 0.25


func _on_hidable_wall_body_exited(body):
	if !body: return
	modulate.a = 1
