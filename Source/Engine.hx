package ;
import model.View;
import mutator.Collision;
import mutator.PlayerMove;
import mutator.Scene;
import nme.display.Sprite;
import mutator.Move;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Engine extends Sprite
{
	private var systems:Array<ISystem>;
	public var scene:Scene;
	public var movement:Move;
	public var playerMovement:PlayerMove;
	public var collision:Collision;
	
	private var entities:Array<Entity>;
	
	public function new() 
	{
		systems = new Array<ISystem>();
		entities = new Array<Entity>();
		
		addSystem(scene = new Scene(this));
		addSystem(movement = new Move());
		addSystem(playerMovement = new PlayerMove());
		addSystem(collision = new Collision());
		
		super();
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
	}
}