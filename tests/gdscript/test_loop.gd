extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_crate_hit() -> void:
	var rules = Rules.new()
	assert_eq(rules.rounds_left(), 1, "one round")
	assert_true(rules.apply_shot(4.0), "in reach")
	assert_eq(rules.crate_points, 0, "points drop")
	assert_false(rules.apply_shot(4.0), "second shot")
	assert_true(rules.refill_rounds(), "yard refill")

func test_empty_shot() -> void:
	var rules = Rules.new()
	assert_false(rules.apply_shot(40.0), "out of reach")
	assert_eq(rules.crate_points, 1, "untouched")

func test_yard_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.may_yard(), "crate remains")
	rules.crate_points = 0
	assert_true(rules.may_yard(), "crate cleared")
	assert_true(load("res://scenes/yard.tscn") != null, "yard loads")
