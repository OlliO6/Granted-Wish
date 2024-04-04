extends Area2D

signal collected_item(item: Item)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	
	var item := Components.get_item(body) as Item
	
	if item and item.try_collect(owner):
		collected_item.emit(item)
