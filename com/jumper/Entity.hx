package com.jumper;
import com.jumper.model.Movement;
import com.jumper.model.Pos;
import com.jumper.model.View;
import com.jumper.promhx.Promise;
import com.jumper.model.Stats;
import com.jumper.model.Atk;
/**
 * ...
 * @author Jonathan Dunlap
 */

class Entity
{
	var lookup:Hash<Dynamic>;
	var types:Int;
	//systems register a callback for when this entity is destroyed
	var onDestroyedCallbacks:Array<Entity -> Void>;
	
	
	public var id:Int;
	
	public function new() 
	{
		lookup = new Hash<Dynamic>();
		onDestroyedCallbacks = new Array<Entity -> Void>();
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
	//entity needs a reference to each system it belongs to for when it is destroyed
	public function destructionListener(onDestroyed:Entity -> Void):Void
	{
		onDestroyedCallbacks.push(onDestroyed);
	}
	
	public function destroy():Void
	{
		EpicGameJam.engine.removeEntity(this);
		for (cb in onDestroyedCallbacks) cb(this);
	}
	
	//==== STATIC
	public static var VIEW:Int = 1 << 0;
	public static var POS:Int = 1 << 1;
	public static var MOVEMENT:Int = 1 << 2;
	public static var STATS:Int = 1 << 3;
	public static var ATK:Int = 1 << 4;
	
	private static var Models = [Atk, Stats, Movement, Pos, View];
	private static var ModelMasks = [ATK, STATS, MOVEMENT, POS, VIEW];
	
	public static function make(components:String):Entity {
		var a = components.split("+");
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