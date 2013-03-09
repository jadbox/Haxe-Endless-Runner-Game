package mutator;
import model.Movement;
import model.MoveNode;
import model.Pos;
import nme.errors.Error;
import model.View;
import model.Collider;

/**
 * ...
 * @author Gback
 */

class Collision implements ISystem
{
	//var models:Array<MoveNode>;
	var viewList:Array<View>;
	var colList:Array<Collider>;
	
	public function new() 
	{
		//models = new Array<MoveNode>();
		
		viewList = new Array<View>();
		colList = new Array<Collider>();
	}
	public function add(entity:Entity):Void {
		viewList.push(entity.fetch(View));
		colList.push(entity.fetch(Collider));
	}
	public function start():Void {
		
	}
	public function stop():Void {
		
	}
	public function update(time:Float):Void {
		var current:Int=0;
		while (current < viewList.length) {
			var view = viewList[current];
			var collider = colList[current];
			collider.colliders = [];
			var curCol:Int = 0;
			while (curCol < viewList.length) {
				if (viewList[curCol].hitTestObject(view))
					collider.colliders.push(colList[curCol].kind);
				curCol++;
			}
			//pos.pt.x += movement.vel.x;
			//pos.pt.y += movement.vel.y;
			current++;
		}
	}
	
	/* INTERFACE ISystem */
	
	public function remove(e:Entity):Void 
	{
		
	}
}