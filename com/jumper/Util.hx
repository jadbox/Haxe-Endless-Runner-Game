package com.jumper;
import com.jumper.model.Pos;
import nme.geom.Rectangle;

/**
 * ...
 * @author gback
 */

class Util 
{

	public static function Assert(expr:Bool, message:String):Void
	{
		if (!expr)
			throw message;
	}
	
	public static function DebugDraw(pos:Pos):Void
	{
		Engine.root.graphics.beginFill(0x0000ff, .5);
		var bounds:Rectangle = pos.getBounds();
		Engine.root.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
	}
	
}