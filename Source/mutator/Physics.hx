package mutator;
import model.Movement;
import model.MoveNode;
import model.Pos;
import nme.errors.Error;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Physics implements ISystem
{
	var posList:Array<Pos>;
	var moveList:Array<Movement>;
	
	public function new() 
	{	
		moveList = new Array<Movement>();
		posList = new Array<Pos>();
	}
	public function add(entity:Entity):Void {
		posList.push(entity.fetch(Pos));
		moveList.push(entity.fetch(Movement));
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
			
			pos.pt.y -= movement.vel.y;
			current++;
		}
	}
}