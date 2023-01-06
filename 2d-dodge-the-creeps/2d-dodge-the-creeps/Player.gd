extends Area2D

signal hit

export var speed = 400.0
var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var direction = Vector2.ZERO
	# Move left and right	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	# Move up and down
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
		
	# Check movement vector is of length 1
	if direction.length() > 0:
		direction = direction.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	# Add movement vector to player position	
	position += direction * speed * delta
	
	# Lock player inside game window
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# Change animations based on movement direction
	$AnimatedSprite.flip_v = false
	if direction.y != 0:
		$AnimatedSprite.animation = "Up"
		$AnimatedSprite.flip_v = direction.y > 0
	elif direction.x != 0:
		$AnimatedSprite.animation = "Right"
		$AnimatedSprite.flip_h = direction.x < 0

func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false
func _on_Player_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit")
	
