extends Sprite

var angular_speed = PI
var speed = 400.0

func _process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		direction = -1
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		direction = 1
	
	rotation += angular_speed * direction * delta
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		velocity = Vector2.UP.rotated(rotation) * speed
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		velocity = Vector2.DOWN.rotated(rotation) * speed
	
	position += velocity * delta
