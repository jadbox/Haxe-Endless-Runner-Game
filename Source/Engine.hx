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
import pools.VectorPool;

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
		trace("hi engine");
		
		map = new Map(this);
		
		systems = new Array<ISystem>();
		entities = new Array<Entity>();
		
		addSystem(scene = new Scene(this));
		//addSystem(movement = new Move(map, EpicGameJam.gameJam));
		addSystem(playerMovement = new PlayerMove(map, EpicGameJam.gameJam));
		addSystem(collision = new Collision());
		
		var lvlBuild:LevelBuilder = new LevelBuilder(this);
		lvlBuild.constructLevel(map);
		//CreateTilesInner(map.m_map);
		
		m_camera = new Camera(this, player.fetch(Pos));
		
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
		//m_player.Update(time);
		m_camera.Update(time);
	}
}