package mutator;
import model.DisplayNode;
import model.Pos;
import model.View;
import nme.display.Sprite;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Scene implements ISystem
{
	private var posList:Array < Pos >;
	private var viewList:Array < View >;
	
	private var root:Sprite;
	
	public function new(root:Sprite) 
	{
		posList = new Array< Pos >();
		viewList = new Array< View >();
		
		this.root = root;
	}
	
	public function update(time:Float):Void {
		var current:Int=0;
		while (current < posList.length) {
			var pos  = posList[current];
			var view = viewList[current];
			view.x = pos.x;
			view.y = pos.y;
			current++;
		}
	}
	public function start():Void {
		
	}
	public function stop():Void {
		
	}
	
	public function add(e:Entity):Void {
		//nodes.push(node);
		viewList.push( e.fetch(View) );
		posList.push ( e.fetch(Pos) );
		root.addChild(e.fetch(View));
	}
	
	
}