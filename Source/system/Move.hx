package system;
import model.Movement;
import model.MoveNode;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Move implements ISystem
{
	var models:Array<MoveNode>;
	
	public function new() 
	{
		models = new Array<Move>();
	}
	public function start():Void {
		
	}
	public function stop():Void {
		
	}
	public function update(time:Float):Void {
		for (model in models) {
			
		}
	}
}