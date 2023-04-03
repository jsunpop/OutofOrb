extends Area2D

signal collect
# Declare member variables here. Examples:
# var a = 2
var screensize
var drop_types = ["red", "orange", "pink", "darkblue", "lightblue", "brown", "yellow", "purple", "white"]





# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_LootDrop_body_entered(body):
	if body.get_name() == 'Player':
		hide()
		queue_free() # Loot Drop disappears after being hit.`
		emit_signal("collect")
		$CollisionShape2D.disabled = true
	else:
		pass


func _on_LootDrop_collect(): # Replace with function body.
	get_parent().spawn_item("Gun", global_position)



