extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	
	var item := Components.get_item(body)
	
	if item:
		_collect_item(item)

func _collect_item(item: Item) -> void:
	item.collect()
	for effect: ItemEffect in item.effects:
		effect.use(owner)
