package ;
import model.Movement;
import model.Pos;
import promhx.Promise;
/**
 * ...
 * @author Jonathan Dunlap
 */
enum Kinds {
		position;
		movement;
}
class Entity
{
	private static var Models = [Movement, Pos];
	
	static var Kind_Count = 2;
	var lookup:Hash<Dynamic>;
	
	public function new() 
	{
		lookup = new Hash<Dynamic>();
		
	}
	public inline function set(n:String, t:Dynamic):Dynamic {
		lookup.set(n, t);
		return t;
	}
	public inline function get(n:String):Dynamic {
		return lookup.get(n);
	}
	public function exists(n:String):Bool {
		return lookup.exists(n);
	}
	
	public static function make(systems:String):Entity {
		return new Entity();
	}
}