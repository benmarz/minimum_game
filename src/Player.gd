class_name Player
extends KinematicBody2D

export (int) var speed = 100

var velocity := Vector2.ZERO
var treasures := 0
var extents : Vector2

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

func killed():
	print("player killed")
