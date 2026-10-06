extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

@onready var walker: CharacterBody3D = $Walker
@onready var chase_eye: Camera3D = $ChaseEye
@onready var crate_mark: MeshInstance3D = $CrateMark

func _physics_process(_delta: float) -> void:
	var wish := Vector2(
		Input.get_action_strength("stride_east") - Input.get_action_strength("stride_west"),
		Input.get_action_strength("stride_south") - Input.get_action_strength("stride_north")
	)
	walker.velocity.x = wish.x * 4.0
	walker.velocity.z = wish.y * 4.0
	if not walker.is_on_floor():
		walker.velocity.y -= 12.0 * _delta
	walker.move_and_slide()
	chase_eye.look_at(walker.global_position)
	if Input.is_action_just_pressed("primary"):
		var distance := walker.global_position.distance_to(crate_mark.global_position)
		if rules.apply_shot(distance):
			var left := float(rules.crate_points) / 3.0
			crate_mark.scale = Vector3.ONE * maxf(left, 0.2)
			crate_mark.visible = rules.crate_points > 0
	if Input.is_action_just_pressed("leap") and walker.is_on_floor():
		walker.velocity.y = 6.0
	if rules.may_yard():
		rules.refill_rounds()
		_go("res://scenes/yard.tscn")

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
