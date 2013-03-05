package ;
import model.Movement;
import model.Pos;
import model.View;
import promhx.Promise;
/**
 * ...
 * @author Jonathan Dunlap
 */

class Entity
{
	var lookup:Hash<Dynamic>;
	public var id:UInt;
	
	public function new() 
	{
		lookup = new Hash<Dynamic>();
	}
	public function set(t:Dynamic):Dynamic {
		if (Std.is(t, Array)) {
			for (mod in cast(t, Array<Dynamic>)) lookup.set( Type.getClassName( Type.getClass(mod) ), mod);
		}else {
			//trace( "class ", Type.getClassName(Type.getClass(t)) );
			lookup.set( Type.getClassName( Type.getClass(t) ) , t);
		}
		return t;
	}
	public function fetch(t:Class<Dynamic>):Dynamic {
		return lookup.get(Type.getClassName(t));
	}
	public function exists(n:String):Bool {
		return lookup.exists(n);
	}
	
	//==== STATIC
	private static var Models = [Movement, Pos, View];
	public static function make(systems:String):Entity {
		var a = systems.split("+");
		var e = new Entity();
		for (i in a) {
			i = "model." + i;
			for (M in Models) {
				if (i == Type.getClassName(M)) e.set(Type.createInstance(M, []));
			}
		}
		return e;
	}
}