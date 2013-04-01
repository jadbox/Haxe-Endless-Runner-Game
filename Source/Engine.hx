package ;
import model.Pos;
import model.View;
import mutator.Collision;
import mutator.PlayerMove;
import mutator.Scene;
import nme.display.Sprite;
import mutator.Move;
import level.Map;
import nme.display.MovieClip;
import nme.display.Graphics;
import maths.Vector2;
import level.TileTypes;
import system.VectorPool;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Engine extends MovieClip
{
	private var systems:Array<ISystem>;
	public var scene:Scene;
	public var movement:Move;
	public var playerMovement:PlayerMove;
	public var collision:Collision;
	
	public var map:Map;
	
	public var player:Entity;
	
	private var entities:Array<Entity>;
	
	private var m_player:MoveableObject;
	private var m_camera:Camera;
	
	public function new() 
	{
		super();
		trace("hi world");
		systems = new Array<ISystem>();
		entities = new Array<Entity>();
		
		addSystem(scene = new Scene(this));
		addSystem(movement = new Move());
		addSystem(playerMovement = new PlayerMove());
		addSystem(collision = new Collision());
		
		map = new Map(this);
		CreateTilesInner(map.m_map);
		var testpool:VectorPool = new VectorPool(10);
		
		m_camera = new Camera(this, m_player);
		
	}
	
	private function CreateTilesInner( tileSet:Array<Int>, addtoScene:Bool=true ):Void
	{
		var index:Int = 0;
		for ( tileCode in tileSet )
		{
			var tile:MovieClip = null;
			
			// calculate the position of each tile: 0,0 maps to Constants.kWorldHalfExtents
			var tileI:Int = Std.int(index%Map.m_Width);
			var tileJ:Int = Std.int(index/Map.m_Width);
			
			var tileX:Int = Std.int(Map.TileCoordsToWorldX(tileI));
			var tileY:Int = Std.int(Map.TileCoordsToWorldY(tileJ));
			
			var tilePos:Vector2 = new Vector2( tileX, tileY );
			
			// create each tile
			switch ( tileCode )
			{
				//
				// foreground tiles
				//
				case TileTypes.kEmpty:
					tile = null;
				case TileTypes.kPlatform:
				{
					tile = new MovieClip( );
					tile.graphics.beginFill( 0xff0000 );
					tile.graphics.drawRect( 0, 0, Constants.kTileSize, Constants.kTileSize );
					tile.graphics.endFill( );
				}
				//
				// characters
				//
				case TileTypes.kPlayer:
				{
					addEntity(player = new Entity());
					var playerPos:Pos = new Pos();
					var playerView:View = new View();
					playerView.graphics.beginFill(0x00ff00);
					playerView.graphics.drawRect(0,0,Constants.kTileSize,Constants.kTileSize);
					//player.set([playerPos, playerView]);
					//tile = new MovieClip();
					//tile.addChild(playerView);
					tile = m_player = new Player();
					m_player.Initialise(tilePos, map, EpicGameJam.gameJam);
					m_player.addChild(playerView);
					playerView.x -= Constants.kTileSize / 2;
					playerView.y -= Constants.kTileSize / 2;
					//tilePos = m_player.m_Pos;
					
				}
				default: Util.Assert( false, "Unexpected tile code " + tileCode );
			}
			
			if ( tile!=null )
			{
				tile.x = tilePos.m_x;
				tile.y = tilePos.m_y;
				tile.cacheAsBitmap = true;
				
				if ( addtoScene )
				{
					this.addChild( tile );
				}
			}
			
			index++;
		}
	}
	
	public function addEntity(entity:Entity):Void {
		entities.push(entity);
	}
	
	public function addSystem(system:ISystem):Void {
		systems.push(system);
	}
	/*public function removeEntity(entity:Entity):Void {
		
	}*/
	public function update(time:Float):Void {
		for (s in systems) s.update(time);
		m_player.Update(time);
		m_camera.Update(time);
	}
}