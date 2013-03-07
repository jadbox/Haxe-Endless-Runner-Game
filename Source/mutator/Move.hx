package mutator;
import model.Movement;
import model.MoveNode;
import model.Pos;
import nme.errors.Error;

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
	public function remove(entity:Entity):Void {
		posList.push(entity.fetch(Pos));
		moveList.push(entity.fetch(Movement));
	}
	public function add(entity:Entity):Void {
		posList.push(entity.fetch(Pos));
		moveList.push(entity.fetch(Movement));
	}
	
	public function update(time:Float):Void {
		var current:Int=0;
		while (current < posList.length) {
			var pos  = posList[current];
			var movement = moveList[current];
			pos.x += movement.x;
			pos.y += movement.y;
			current++;
		}
	}
}