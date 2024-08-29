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
	var x: int
	var y: int
	func _init(x_: int, y_: int):
		self.x = x_
		self.y = y_

	static func from_ab(a: int, b: int) -> HexVec:
		return HexVec.new(b, -a - b)
	
	static func from_ac(a: int, c: int) -> HexVec:
		return HexVec.new(c, -a + c)
	
	static func from_bc(b: int, c: int) -> HexVec:
		return HexVec.new(b + c, -b + c)

	static func from_vec(v: Vector2i) -> HexVec:
		return HexVec.new(v.x, v.y)

	func to_vec() -> Vector2i:
		return Vector2i(x, y)

	func add_in_dir(dir: Direction, dist: int = 1) -> HexVec:
		match dir:
			Direction.North:
				return HexVec.new(x, y - dist)
			Direction.NorthEast:
				return HexVec.new(x + dist, y - dist)
			Direction.SouthEast:
				return HexVec.new(x + dist, y + dist)
			Direction.South:
				return HexVec.new(x, y + dist)
			Direction.SouthWest:
				return HexVec.new(x - dist, y + dist)
			Direction.NorthWest:
				return HexVec.new(x - dist, y - dist)
			_:
				return


func mouse_pos() -> HexVec:
	return HexVec.from_vec(
		$TileMap.local_to_map(
			$TileMap.to_local(
				get_global_mouse_position()
			)
		)
	)

	
func tile_type_to_coord(t: TileType):
	match t:
		TileType.Empty:
			return Vector2i(12, 4)
		TileType.Twig:
			return Vector2i(12, 5)
		TileType.Rock:
			return Vector2i(13, 5)

func place_tile(t: TileType, v: HexVec):
	$TileMap.set_cell(
		0,
		v.to_vec(),
		$TileMap.tile_set.get_source_id(0),
		tile_type_to_coord(t)
	)
			
# Called when the node enters the scene tree for the first time.
func _ready():
	place_tile(TileType.Empty, HexVec.new(0, 0))
	place_tile(TileType.Twig, HexVec.new(0, 1))
	place_tile(TileType.Rock, HexVec.new(0, 2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	place_tile(TileType.Rock, mouse_pos())
