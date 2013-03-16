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


/**
 * @author Jonathan Dunlap
 */
class EpicGameJam extends Sprite {

	public static var keyInput:KeyboardInput;
	
	public function new () {
		
		super ();
		
		initialize ();
	}
	
	private function initialize ():Void {
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		keyInput = new KeyboardInput(Lib.current.stage);
		
		
		var game:Engine = new Engine();
		addChild(game);
		/*var e:Entity = Entity.make("Pos+Movement");
		e.set(View.get());
		//trace("post set");
		game.addEntity(e);
		
		//var scene:Scene = new Scene(this);
		//game.addSystem(scene);
		game.movement.add(e);
		game.scene.add(e);*/
		
		/*var player:Entity = new Entity();
		//set player as the unique case for scene
		player.id = 1;
		var v:View = View.get("assets/megapony.png");
		v.scaleX = v.scaleY = .2;
		player.set([new Pos(), new Movement(25), v, new Collider("player", v.width, v.height)]);
		game.addEntity(player);
		game.playerMovement.add(player);
		game.scene.add(player);
		game.collision.add(player);
		
		var ground:Entity = new Entity();
		var groundView:View = new View();
		groundView.graphics.beginFill(0xff0000, 1);
		groundView.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, 10);
		var groundPos:Pos = new Pos();
		groundPos.y = Lib.current.stage.stageHeight - 10;
		ground.set([groundPos, groundView, new Collider("ground", groundView.width, groundView.height)]);
		game.scene.add(ground);
		game.collision.add(ground);*/
		
		
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