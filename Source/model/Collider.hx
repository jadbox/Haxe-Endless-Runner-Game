package model;

/**
 * ...
 * @author gback
 */

class Collider 
{

	public var colliders:Array<CollisionNode>;
	//public var colPositions:Array<View>;
	public var kind:String;
	public var width:Float;
	public var height:Float;
	
	public function new(kind:String = "default", width:Float = 0, height:Float = 0) 
	{
		colliders = new Array<CollisionNode>();
		//colPositions = new Array<View>();
		this.kind = kind;
		this.width = width;
		this.height = height;
	}
	
}