class_name Player
extends KinematicBody2D

signal player_killed
export (int) var speed = 100

var velocity := Vector2.ZERO
var treasures := 0
var extents : Vector2
var dead := false

func _ready():
	Global.player = self

func get_extents():
	return $CollisionShape2D.shape.extents

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)


func die():
	if not dead:
		dead = true
		print("player killed")
		emit_signal("player_killed")


# must be called during idle period
func disable():
	$CollisionShape2D.disabled = true


func enable():
	dead = false
	$CollisionShape2D.disabled = false

func count_treasures():
	treasures = 0
	for level in Global.treasures:
		treasures += Global.treasures[level].size()
	print("player has ", treasures, " treasures")
