package ;


import model.Collider;
import model.Movement;
import model.View;
import model.Pos;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.MovieClip;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Lib;
import mutator.Scene;
import pools.VectorPool;


/**
 * @author Jonathan Dunlap
 */
class EpicGameJam extends Sprite {

	public static var keyInput:KeyboardInput;
	
	// fast allocator for vector2s, cleared once per frame
	static public var m_gTempVectorPool:VectorPool;
	
	static public var gameJam:EpicGameJam;
	
	public function new () {
		
		super ();
		
		initialize ();
	}
	
	private function initialize ():Void {
		
		gameJam = this;
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		keyInput = new KeyboardInput(Lib.current.stage);
		
		m_gTempVectorPool = new VectorPool(10000);
		
		var game:Engine = new Engine();
		addChild(game);
		
		trace("screen size: " + Lib.current.stage.stageWidth + ", " + Lib.current.stage.stageHeight);
		
		
		addEventListener(Event.ENTER_FRAME, function(e):Void {
			game.update(1/30);
		});
	}
	
	
	// Entry point
	public static function main () {
		trace("main");
		Lib.current.addChild (new EpicGameJam ());
		
	}
	
	
}