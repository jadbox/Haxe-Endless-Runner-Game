package model;

/**
 * ...
 * @author gback
 */

class Collider 
{

	public var colliders:Array<String>;
	public var kind:String;
	
	public function new(kind:String = "default") 
	{
		colliders = new Array<String>();
		this.kind = kind;
	}
	
}