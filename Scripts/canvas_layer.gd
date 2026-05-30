extends CanvasLayer

@onready var collectible_label: Label = $Collectibles/Label

func _ready() -> void:
	GameManager.collectible_count_changed.connect(update_collectible_count)
	update_collectible_count(GameManager.collectible_count)

func update_collectible_count(count: int) -> void:
	collectible_label.text = "x %s" % count
