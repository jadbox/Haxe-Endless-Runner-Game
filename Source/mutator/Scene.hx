package mutator;
import model.DisplayNode;
import nme.display.Sprite;

/**
 * ...
 * @author Jonathan Dunlap
 */

class Scene implements ISystem
{
	private var nodes:Array < DisplayNode >;
	private var root:Sprite;
	
	public function new(root:Sprite) 
	{
		nodes = new Array< DisplayNode >();
		this.root = root;
	}
	
	public function update(time:Float):Void {
		
	}
	public function start():Void {
		
	}
	public function stop():Void {
		
	}
	
	public function add(node:DisplayNode):Void {
		nodes.push(node);
		
		root.addChild(node.view);
	}
	
	
}