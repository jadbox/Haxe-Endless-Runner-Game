package mutator;
import model.Movement;
import model.MoveNode;
import model.Pos;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Move implements ISystem
{
	//var models:Array<MoveNode>;
	var posList:Array<Pos>;
	var moveList:Array<Movement>;
	
	public function new() 
	{
		//models = new Array<MoveNode>();
		
		moveList = new Array<Movement>();
		posList = new Array<Pos>();
	}
	public function add(entity:Entity):Void {
		posList.push(entity.get("pos"));
		moveList.push(entity.get("movement"));
	}
	public function start():Void {
		
	}
	public function stop():Void {
		
	}
	public function update(time:Float):Void {
		var current:Int=0;
		while (current < posList.length) {
			var pos  = posList[current];
			var movement = moveList[current];
			pos.pt.x += movement.vel.x;
			pos.pt.y += movement.vel.y;
			current++;
		}
	}
}