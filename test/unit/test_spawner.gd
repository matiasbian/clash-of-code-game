extends GutTest

func test_assert_spawner():
	var spawner:Spawner = Spawner.new()
	spawner.dirPrefab = load("res://Prefabs/Blocks/Directional.tscn") # resource is loaded when line is executed
	spawner.jumpPrefab = load("res://Prefabs/Blocks/Jump.tscn") # resource is loaded when line is executed
	spawner.ifPrefab = load("res://Prefabs/Blocks/IF.tscn") # resource is loaded when line is executed
	spawner.startPrefab = load("res://Prefabs/Blocks/Start.tscn")
	spawner.finishPrefab = load("res://Prefabs/Blocks/Finish.tscn")
	spawner.spikePrefab = load("res://Prefabs/Blocks/Spikes.tscn")
	spawner.game_manager = Game_Manager.new()
	
	var levelData = "{\n    \"levelNumber\": 1,\n    \"label\": \"asdasdasd\",\n    \"structure\": {\n        \"elements\": [\n            {\n                \"positionX\": 0,\n                \"positionY\": 0,\n                \"type\": \"start\"\n            },\n            {\n                \"positionX\": 1,\n                \"positionY\": 0,\n                \"type\": \"movement\"\n            },\n            {\n                \"positionX\": 2,\n                \"positionY\": 0,\n                \"type\": \"movement\"\n            },\n            {\n                \"positionX\": 2,\n                \"positionY\": 1,\n                \"type\": \"movement\"\n            },\n            {\n                \"positionX\": 3,\n                \"positionY\": 1,\n                \"type\": \"if\"\n            },\n            {\n                \"direction\": \"up\",\n                \"positionX\": 4,\n                \"positionY\": 1,\n                \"type\": \"jump\"\n            },\n            {\n                \"positionX\": 4,\n                \"positionY\": 2,\n                \"type\": \"finish\"\n            }\n        ]\n    },\n    \"perfectSteps\": 5\n}"
	var parsedData = JSON.parse_string(levelData)
	var blocks = spawner.instantiateLevel(parsedData)
	assert_eq(blocks.size(), 7, "true")
