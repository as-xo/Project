extends PanelContainer
class_name Slot

@export var codeLineResource: CodeLine = null


func set_line(item_resource: CodeLine) -> void:
	codeLineResource = item_resource
	%TextureRect.texture = codeLineResource.texture
	%Label.text = codeLineResource.code_text if codeLineResource else ""

func _get_drag_data(_at_position):
	if not codeLineResource:
		return
	
	var preview_label = Label.new()
	
	preview_label.text = codeLineResource.code_text
	preview_label.expand_mode = 1
	preview_label.rect_min_size = Vector2(200, 30)
	
	var preview = Control.new()
	preview.add_child(preview_label)
	
	set_drag_preview(preview)
	
	return {
		"codeLineResource": codeLineResource,
		"source": self
	}
	

func _can_drop_data(_at_position, data):
	return data.has("codeLineResource") and data["codeLineResource"] is CodeLine

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if data is Dictionary:
		var dict = data as Dictionary
		if codeLineResource == null:
			set_line(data["codeLineResource"])
			data["source"].set_code_line()
		else:
			var temp := codeLineResource
			set_line(data["codeLineResource"])
			data["source"].set_line(temp)


func set_code_line() -> void:
	%Label.text = ""
	codeLineResource = null
	
