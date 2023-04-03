extends RigidBody2D

signal shothit

var speed = 300
var velocity = Vector2(1,0)
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	
#func _physics_process(delta):
#	velocity = (velocity.normalized() * speed)
#	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_area_entered(body):
	if body is Area2D:
		emit_signal("shothit")
		queue_free()
		hide()
	else:
		queue_free()
		hide()

func _on_Bullet_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group('damageable'):
		body.free()
		queue_free()
		hide()
	if body is TileMap:
		queue_free()
		hide()
	else:
		queue_free()
		hide()


func _on_Bullet_shothit():
#	self.get_parent().spawn_item("Loot", global_position) # Replace with function body.
	get_parent().mob_killed()

func spawn_item(item_type, item_position):
	print('yo')
	if item_type == "Loot":
		if randf() < 0.5:
			var loot = preload("res://LootDrop.tscn")
			var drop = loot.instance()
			drop.global_position = item_position
			get_parent().add_child(drop)
	if item_type == "Gun":
		var gun = preload("res://Gun.tscn").instance()
		gun.global_position = item_position
		get_parent().add_child(gun)
