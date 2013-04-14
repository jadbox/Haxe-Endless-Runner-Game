package mutator;
import model.Movement;
import model.MoveNode;
import model.Pos;
import nme.errors.Error;
import maths.Vector2;
import level.Map;
import geom.Contact;

/**
 * ...
 * @author Greg Back
 */

class Move implements ISystem
{
	var currentEntity:Int = 0;
	
	//var models:Array<MoveNode>;
	var posList:Array<Pos>;
	var velList:Array<Movement>;
	
	var m_platformer:EpicGameJam;
	var m_map:Map;
	var m_contact:Contact;
	
	public function new(map:Map, parent:EpicGameJam) 
	{
		//models = new Array<MoveNode>();
		
		velList = new Array<Pos>();
		posList = new Array<Movement>();
		
		
	}
	public function remove(entity:Entity):Void {
		posList.push(entity.fetch(Pos));
		moveList.push(entity.fetch(Movement));
	}
	public function add(entity:Entity):Void {
		var pos:Pos = entity.fetch(Pos);
		pos.radius = Constants.kPlayerWidth / 2;
		pos.halfExtents = new Vector2( pos.radius, pos.radius );
		posList.push(pos);
		moveList.push(entity.fetch(Movement));
		
		
	}
	
	public function update(time:Float):Void {
		while (current < posList.length) {
			var pos  = posList[current];
			var movement = moveList[current];
			pos.x += movement.x;
			pos.y += movement.y;
			current++;
		}
	}
}