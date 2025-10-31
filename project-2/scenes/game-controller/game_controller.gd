extends Node

var player_hp : int = 3
var has_sword : bool = false
var keys : int = 0
var has_weapon : bool = false
var player_spawn_pos: Vector2
var opened_chests : Array[String]
var opened_doors : Array[String]

func collect_key():
	keys += 1
	
func use_key():
	if keys > 0:
		keys -= 1
