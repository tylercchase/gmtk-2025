extends Label


func show_value(value, new_position):
    text = value
    global_position = new_position
    var tween = get_tree().create_tween()
    tween.set_parallel(true)
    tween.tween_property(self, "global_position", global_position + Vector2(10,10).rotated(randf_range(-1.0, 1.0)), 2)
    tween.tween_property(self, "modulate:a", 0.0, 2)
    tween.set_parallel(false)
    tween.tween_callback(self.queue_free)