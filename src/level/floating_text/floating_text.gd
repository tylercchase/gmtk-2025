extends Label


func show_value(value, new_position):
    text = value
    global_position = new_position
    var tween = get_tree().create_tween()
    tween.tween_property(self, "global_position", global_position + Vector2(10,10), 2)
    tween.tween_property(self, "modulate:a", 0.0, 2)
    tween.tween_callback(self.queue_free)