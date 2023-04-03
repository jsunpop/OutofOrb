extends KinematicBody2D
signal hit

onready var fireDelayTimer := $FireDelayTimer
export var speed = 200 # How fast the player will move (pixels/sec).
var bullet_path = preload('res://Bullet.tscn')
var bullet_speed = 300
var screen_size # Size of the game window.
var velocity # The player's movement vector.
var shotReady = true
var canShoot = true
var shootAllow = false
export var fireDelay: float = 0.2

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("fire") and canShoot and shootAllow:
		var bullet_instance = bullet_path.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
		get_parent().add_child(bullet_instance)
		canShoot = false
		yield(get_tree().create_timer(.2), "timeout")
		canShoot = true
	var z = 0
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		 velocity.y -= 1
	#if Input.is_action_pressed("shoot_right"):
		#if shotReady == true and canShoot == true:
			#z = 1
			#shotReady = false
			#fireDelayTimer.start()
#	if Input.is_action_pressed("shoot_left"):
#		if shotReady == true and canShoot == true:
#			z = -1
#			shotReady = false
#			fireDelayTimer.start()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
#		if z == 1:
#			$AnimatedSprite.animation = "shoot"
#			$AnimatedSprite.flip_h = false
#			shooting_right()
#		if z == -1:
#			$AnimatedSprite.animation = "shoot"
#			$AnimatedSprite.flip_h = true
#			shooting_left()
#
	else:
		$AnimatedSprite.stop()
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0

	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		#$AnimatedSprite.flip_v = velocity.y > 0 
		
	move_and_collide(velocity * delta)
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

		
func _on_Player_body_entered(body):
	if body is TileMap:
		if velocity.x < 0:
			position.x =  position.x + 50
		elif velocity.x > 0:
			position.x =  position.x - 50
		if velocity.y < 0:
			position.y = position.y + 50
		elif velocity.y > 0:
			position.y = position.y - 50 
			
		#$CollisionShape2D.set_deferred("disabled", true)

func shooting_right():
	var bullet = bullet_path.instance()
	get_parent().add_child(bullet)
	bullet.position = $right_shot.global_position

func shooting_left():
	var bullet = bullet_path.instance()
	bullet.velocity = Vector2(-1,0)
	get_parent().add_child(bullet)
	bullet.position = $left_shot.global_position

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_Player_area_entered(area):
	if(area.is_in_group("damageable")):
		area.queue_free()
		hide() # Player disappears after being hit.
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)




func _on_FireDelayTimer_timeout():
	shotReady = true # Replace with function body.
