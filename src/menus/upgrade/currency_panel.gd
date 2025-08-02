extends PanelContainer

@export var currency_label: RichTextLabel


var template = ""

func _ready() -> void:
    template = currency_label.text
    update_text()


func update_text():
    print(State.inventory)
    if State.inventory.has("apple"):
        currency_label.text = template % State.inventory["apple"]