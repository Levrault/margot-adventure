extends Node

# Read and parse Json file
static func get_json(file_path: String) -> Dictionary:
	var file := File.new()

	if file.open(file_path, file.READ) != OK:
		print_debug("get_json: file cannot been read")
		return {}

	var text_content := file.get_as_text()
	file.close()
	var data_parse = JSON.parse(text_content)
	if data_parse.error != OK:
		print_debug("get_json: error while parsing")
		return {}
	return data_parse.result
