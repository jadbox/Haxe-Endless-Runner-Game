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
	var types:Int;
	public var id:Int;
	
	public function new() 
	{
		lookup = new Hash<Dynamic>();
		types = 0;
	}
	
	public function set(t:Dynamic):Dynamic {
		if (Std.is(t, Array)) {
			for (mod in cast(t, Array<Dynamic>)) _set(mod);
		}else _set(t);
		return t;
	}
	
	private inline function _set(t:Dynamic):Void {
		for (i in 0...Models.length) {
			var M = Models[i];
			if (Type.getClassName(Type.getClass(t)) == Type.getClassName(M)) {
				types |= ModelMasks[i];
				break;
			}
		}
		
		lookup.set( Type.getClassName( Type.getClass(t) ) , t);
	}
	
	public function fetch(t:Class<Dynamic>):Dynamic {
		return lookup.get(Type.getClassName(t));
	}
	
	public function exists(n:Int):Bool {
		return types & n != 0; //lookup.exists(n);
	}
	
	//==== STATIC
	public static var VIEW:Int = 1 << 0;
	public static var POS:Int = 1 << 1;
	public static var MOVEMENT:Int = 1 << 2;
	
	private static var Models = [Movement, Pos, View];
	private static var ModelMasks = [MOVEMENT, POS, VIEW];
	
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