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
	public function update(time:Float):Void {
		for (model in models) {
			
		}
	}
}