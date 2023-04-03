extends Area2D

onready var path_follow = get_parent()
var screen_size
#var velocity = Vector2(-100, 0)
export (int) var speed = 100 # Maximum speed range.
var bullet = preload("res://Bullet.tscn")

func _ready(): 

	screen_size = get_viewport_rect().size
	#var mob_types = $AnimatedSprite.frames.get_animation_names()
	#$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _physics_process(delta):
	if path_follow is PathFollow2D:
		path_follow.set_offset(path_follow.get_offset() + speed * delta)
	#if(position.x < 100):
	#	velocity.y = 100
	#velocity = velocity.normalized() * speed
	#position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)
	#if(velocity.x != 0 or velocity.y != 0):
		$AnimatedSprite.animation = "swing"
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.flip_v = true
		$AnimatedSprite.playing = true
	#else:
		#$AnimatedSprite.playing = false
	
		
#func _on_VisibilityNotifier2D_screen_exited():
	#queue_free()


func _on_Mob_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is RigidBody2D:
		print('hi')
		body.emit_signal('shothit')
		queue_free()
		body.spawn_item("Loot", global_position) # Replace with function body.
	if body is KinematicBody2D:
		body.emit_signal('hit')
		queue_free()
		body.hide()
		$CollisionShape2D.set_deferred("disabled", true)
