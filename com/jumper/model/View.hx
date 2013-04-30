package com.jumper.model;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.installer.Assets;
import com.jumper.promhx.Promise;
import com.jumper.promhx.Promise;

/**
 * ...
 * @author Jonathan Dunlap
 */
typedef Prom = Promise<View>;
class View extends Sprite
{	
	public function new() 
	{
		super();
	}
	
	
	public static function get(url:String="assets/test.png"):View {
		//var p:Prom = new Prom();
		
		var logo:Bitmap = new Bitmap (Assets.getBitmapData (url));
		var d:View = new View();
		d.addChild(logo);
		
		return d;
	}
	public static function load(url:String):Prom {
		var p:Prom = new Prom();
		
		
		
		return p;
	}
}