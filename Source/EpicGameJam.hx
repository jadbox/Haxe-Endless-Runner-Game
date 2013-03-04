package ;


import model.View;
import model.Pos;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;


/**
 * @author Jonathan Dunlap
 */
class EpicGameJam extends Sprite {
	
	
	public function new () {
		
		super ();
		
		initialize ();
	}
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		
		
		var game:Engine = new Engine();
		addChild(game);
		
		var e:Entity = new Entity();
		e.set("Pos", new Pos());
		e.set("View", View.get());
	}
	
	
	// Entry point
	public static function main () {
		
		Lib.current.addChild (new EpicGameJam ());
		
	}
	
	
}