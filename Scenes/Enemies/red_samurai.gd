extends PathFollow2D
@onready var red_samurai = $"."
@onready var sprite_2d = $CharacterBody2D/AnimatedSprite2D

var previous_x = 0.0
var previous_y = 0.0

var speed = 150
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	change_animation()
	move(delta)

func move(delta):
	set_progress(get_progress() + speed * delta)
	
func change_animation():
	var y = abs(red_samurai.position.y - previous_y)
	var x = abs(red_samurai.position.x - previous_x)
	if (y > 2):
		if (red_samurai.position.y - previous_y < 0):
			sprite_2d.animation = "up"
		elif (red_samurai.position.y - previous_y > 0):
			sprite_2d.animation = "down"
	if (x > 2):
		if (red_samurai.position.x - previous_x > 0):
			sprite_2d.animation = "right"
		elif (red_samurai.position.x - previous_x < 0):
			sprite_2d.animation = "left"
	previous_x = red_samurai.position.x
	previous_y = red_samurai.position.y
