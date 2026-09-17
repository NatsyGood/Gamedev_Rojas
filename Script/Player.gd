extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const GRAVITY = 800.0

var jumps_remaining = 2
var max_jumps = 2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += GRAVITY * delta
	
	# Reset jumps on ground
	if is_on_floor():
		jumps_remaining = max_jumps
		velocity.y = 0
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		velocity.y = JUMP_VELOCITY
		jumps_remaining -= 1
	
	# Horizontal movement
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	
	#Flipping Sprite
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$AnimatedSprite2D.flip_h = true
		
	# Animation
	if is_on_floor():
		if direction == 0:
			$AnimatedSprite2D.play("Idle")
		else:
			$AnimatedSprite2D.play("Run")
	else:
		$AnimatedSprite2D.play("Jump")
	
	move_and_slide()
