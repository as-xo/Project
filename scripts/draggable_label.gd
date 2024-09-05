extends Label


# Function to handle the start of drag
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if self.has_point(event.position):
			# Start drag with label text as data
			var drag_data = {"text": self.text}
			start_drag(drag_data, self)
			print("Dragging: ", self.text)

# Ensure to set up drag preview
func get_drag_preview() -> Control:
	var preview = Label.new()
	preview.text = self.text
	preview.rect_min_size = Vector2(100, 30)  # Size of the drag preview
	return preview
