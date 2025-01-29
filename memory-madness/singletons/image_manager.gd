extends Node


const FRAME_IMAGES: Array[Texture2D] = [
	preload("res://assets/frames/blue_frame.png"),
	preload("res://assets/frames/green_frame.png"),
	preload("res://assets/frames/red_frame.png"),
	preload("res://assets/frames/yellow_frame.png"),
] 


var _item_images: Array[ItemImage] = []


func _ready() -> void:
	var ir: ImageFilesList = load("res://resources/image_files_list.tres")
	for file_path in ir.get_file_names():
		add_file_to_list(file_path)


func add_file_to_list(file_path: String) -> void:
	var new_item_image: ItemImage = ItemImage.new(
		file_path.get_file(),
		load(file_path)
	)
	_item_images.append(new_item_image)


func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()


func get_random_item_image() -> ItemImage:
	return _item_images.pick_random()


func get_image(index: int) -> ItemImage:
	return _item_images[index]


func shuffle_images() -> void:
	_item_images.shuffle()
