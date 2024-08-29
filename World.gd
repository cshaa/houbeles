extends Node2D

enum TileType {
	Empty,
	Twig,
	Rock
}

enum Direction {
	North,
	NorthEast,
	SouthEast,
	South,
	SouthWest,
	NorthWest
}

class HexVec:
	static func AB(a: int, b: int) -> Vector2i:
		return Vector2i(b, a + b)
	
	static func AC(a: int, c: int) -> Vector2i:
		return Vector2i(-c, a - c)
	
	static func BC(b: int, c: int) -> Vector2i:
		return Vector2i(b - c, b + c)


func tile_type_to_coord(t: TileType):
	match t:
		TileType.Empty:
			return Vector2i(12, 4)
		TileType.Twig:
			return Vector2i(12, 5)
		TileType.Rock:
			return Vector2i(13, 5)

func place_tile(t: TileType, x: int, y: int):
	$TileMap.set_cell(
		0,
		Vector2i(x, y),
		$TileMap.tile_set.get_source_id(1),
		tile_type_to_coord(t)
	)
			
# Called when the node enters the scene tree for the first time.
func _ready():
	place_tile(TileType.Empty, 0, 0)
	place_tile(TileType.Twig, 0, 1)
	place_tile(TileType.Rock, 0, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	pass
