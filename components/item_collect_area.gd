extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	
	var item := Components.get_item(body) as Item
	
	if item:
		item.try_collect(owner)
