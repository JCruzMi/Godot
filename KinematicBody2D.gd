extends KinematicBody2D

const Up = Vector2(0,-1)
const Gravity = 20
const Acceleration = 50	
const Max_Speed = 200
const Jump_Hight = -400
var motions = Vector2()

func _physics_process(delta):
	motions.y += Gravity
	var friction = false
	
	if Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D):
		$Sprite.flip_h = false
		$Sprite.play("Run")
		motions.x = min(motions.x + Acceleration, Max_Speed)
	elif Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A):
		motions.x = max(motions.x-Acceleration, -Max_Speed)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idel")
		friction = true
		motions.x = lerp(motions.x, 0, 0.2)
	
	if is_on_floor():
		if Input.is_key_pressed(KEY_W):
			motions.y = Jump_Hight
		if friction == true:
			motions.x = lerp(motions.x, 0, 0.2)
	else:
		if motions.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction == true:
			motions.x = lerp(motions.x, 0, 0.05)

	motions = move_and_slide(motions, Up)
	
	pass
	