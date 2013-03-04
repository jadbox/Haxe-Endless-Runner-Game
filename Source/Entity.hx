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
		trace("start");
	}
	public inline function set(t:Dynamic):Dynamic {
		trace( Type.getClassName(t) );
		lookup.set(Type.getClassName(t), t);
		return t;
	}
	public function fetch(t:Class<Dynamic>):Dynamic {
		return lookup.get(Type.getClassName(t));
	}
	public function exists(n:String):Bool {
		return lookup.exists(n);
	}
	
	public static function make(systems:String):Entity {
		return new Entity();
	}
}