extends RefCounted

var crate_points := 1
var rounds := 1
const REACH := 12.0

func rounds_left() -> int:
	return rounds

func shot_lands(distance: float) -> bool:
	return distance >= 0.0 and distance <= REACH

func apply_shot(distance: float) -> bool:
	if not shot_lands(distance):
		return false
	if rounds <= 0:
		return false
	rounds -= 1
	crate_points = maxi(crate_points - 1, 0)
	return true

func refill_rounds() -> bool:
	if rounds > 0:
		return false
	rounds = 1
	return true

func reset_crate() -> void:
	crate_points = 1
	rounds = 1

func may_yard() -> bool:
	return crate_points <= 0
