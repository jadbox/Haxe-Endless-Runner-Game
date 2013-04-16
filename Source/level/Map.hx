package level;


import maths.Vector2;
import geom.AABB;

/**
 * ...
 * @author gback
 */

class Map 
{
	static private var m_gTileCentreOffset:Vector2 = new Vector2( Constants.kTileSize/2, Constants.kTileSize/2 );
	static private var m_gTileHalfExtents:Vector2 = new Vector2( Constants.kTileSize/2, Constants.kTileSize/2 );
	
	private var m_aabbTemp:AABB;
	private var m_Platformer:Engine;
	
	public static var m_Width:Int = 20;
	public static var m_Height:Int = 19;
		
	// map for the level
	public var m_map(default,null):Array<Int>;
	

	public function new(platformer:Engine) 
	{
		m_map = 
		[
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,1,1,1,1,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,1,1,0,0,1,1,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,1,0,0,0,1,1,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,0,3,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,
			1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,
			1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,
			1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,0,0,0,0,1,
			1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
			
		];
		m_Platformer = platformer;
		Util.Assert(m_map.length == m_Width * m_Height, "Map Dimensions don't match constants!");
		m_aabbTemp = new AABB();
		
		//the map defines world extents
			Constants.kWorldHalfExtents = new Vector2( m_Width*Constants.kTileSize*0.5, m_Height*Constants.kTileSize*0.5 );
		
	}
	
	public function GetTile( i:Int, j:Int ):Int
	{
		//Assert( i>=0&&i<=m_Width && j>=0 && j<=m_Height, "Map.GetTile(): index out of range" );
		//return m_Map[j*m_Width+i];
		return GetTileSafe( m_map, i, j );
	}
	
	/// <summary>
	/// 
	/// </summary>
	public function GetTileSafe( map:Array<Int>, i:Int, j:Int ):Int
	{
		if ( i>=0&&i<m_Width&&j>=0&&j<m_Height )
		{
			return map[j*m_Width+i];
		}
		else 
		{
			return TileTypes.kInvalid;
		}
	}
	
	/// <summary>
	/// calculate the position of a tile: 0,0 maps to Constants.kWorldHalfExtents
	/// </summary>
	static public function TileCoordsToWorldX( i:Int ):Float
	{
		return i*Constants.kTileSize - Constants.kWorldHalfExtents.m_x;
	}
	
	/// <summary>
	/// calculate the position of a tile: 0,0 maps to Constants.kWorldHalfExtents 
	/// </summary>
	static public function TileCoordsToWorldY( j:Int ):Float
	{
		return j*Constants.kTileSize - Constants.kWorldHalfExtents.m_y;
	}
	
	/// <summary>
	/// go from world coordinates to tile coordinates
	/// </summary>
	static public function WorldCoordsToTileX( worldX:Float ):Int
	{
		return Std.int(( worldX+Constants.kWorldHalfExtents.m_x )/Constants.kTileSize);
	}
	
	/// <summary>
	/// go from world coordinates to tile coordinates
	/// </summary>
	static public function WorldCoordsToTileY( worldY:Float ):Int
	{
		return Std.int(( worldY+Constants.kWorldHalfExtents.m_y )/Constants.kTileSize);
	}
	
	/// <summary>
	/// Get the tile of a world coordinate in Vector2
	/// </summary>
	public function GetTileFromPos( pos:Vector2 ):Int
	{
		var i:Int = WorldCoordsToTileX( pos.m_x );
		var j:Int = WorldCoordsToTileY( pos.m_y );
		
		return GetTile( i, j );
	}
	
	/// <summary>
	/// 
	/// </summary>
	static public function IsTileObstacle( tile:Int ):Bool
	{
		return cast(tile, Int) == TileTypes.kPlatform;
	}
	
	/// <summary>
		/// 
		/// </summary>
		static public function FillInTileAabb( i:Int, j:Int, outAabb:AABB ):Void
		{
			outAabb.Initialise( new Vector2
								(
									TileCoordsToWorldX(i), 
									TileCoordsToWorldY(j)
								).AddTo(m_gTileCentreOffset), m_gTileHalfExtents );
		}
		
		/// <summary>
		/// Call out to the action for each tile within the given world space bounds
		/// </summary>
		public function DoActionToTilesWithinAabb( min:Vector2, max:Vector2, action:Dynamic, dt:Float ):Void
		{
			// round down
			var minI:Int = WorldCoordsToTileX(min.m_x);
			var minJ:Int = WorldCoordsToTileY(min.m_y);
			
			// round up
			var maxI:Int = WorldCoordsToTileX(max.m_x+0.5);
			var maxJ:Int = WorldCoordsToTileY(max.m_y+0.5);
			var i:Int = minI;
			while ( i <= maxI )
			{
				var j:Int = minJ;
				while (  j <= maxJ )
				{
					// generate aabb for this tile
					FillInTileAabb( i, j, m_aabbTemp );
					
					// call the delegate on the main collision map
					action( m_aabbTemp, GetTile( i, j ), dt, i, j );
					j++;
				}
				 i++;
			}
		}
	
}