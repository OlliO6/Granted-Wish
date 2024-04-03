extends Node

var game: Game

func get_player() -> Player:
	return game.get_player()

func get_blood_viewport() -> SubViewport:
	return game.blood_viewport
