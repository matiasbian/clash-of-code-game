extends GutTest

func test_assert_spawner():
	var spawner:Spawner = Spawner.new()
	spawner.dirPrefab = load("res://Prefabs/Blocks/Directional.tscn") # resource is loaded when line is executed
	spawner.startPrefab = load("res://Prefabs/Blocks/Start.tscn")
	spawner.finishPrefab = load("res://Prefabs/Blocks/Finish.tscn")
	spawner.spikePrefab = load("res://Prefabs/Blocks/Spikes.tscn")
	spawner.game_manager = Game_Manager.new()
	
	var levelData = "{\n    \"levelNumber\": 1,\n    \"label\": \"LEVEL_1\",\n    \"structure\": {\n        \"elements\": [\n            {\n                \"positionX\": 0,\n                \"positionY\": 0,\n                \"type\": \"start\"\n            },\n            {\n                \"positionX\": 1,\n                \"positionY\": 0,\n                \"type\": \"movement\"\n            },\n            {\n                \"positionX\": 2,\n                \"positionY\": 0,\n                \"type\": \"movement\"\n            },\n            {\n                \"positionX\": 3,\n                \"positionY\": 0,\n                \"type\": \"finish\"\n            }\n        ]\n    },\n    \"perfectSteps\": 7\n}"
	var parsedData = JSON.parse_string(levelData)
	var blocks = spawner.instantiateLevel(parsedData)
	assert_eq(blocks.size(), 4, "true")
