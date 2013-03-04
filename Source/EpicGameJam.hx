package ;


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
		trace("started");
		var e:Entity = new Entity();
		e.set(new Pos());
		e.set(new Movement()); 
		e.set(View.get());
		trace("post set");
		game.addEntity(e);
		
		//var scene:Scene = new Scene(this);
		//game.addSystem(scene);
		game.movement.add(e);
		game.scene.add(e);
		
		addEventListener(Event.ENTER_FRAME, function(e):Void {
			game.update(1);
		});
	}
	
	
	// Entry point
	public static function main () {
		trace("main");
		Lib.current.addChild (new EpicGameJam ());
		
	}
	
	
}