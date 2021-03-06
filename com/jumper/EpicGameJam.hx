package com.jumper;


import com.jumper.model.Collider;
import com.jumper.model.Movement;
import com.jumper.model.View;
import com.jumper.model.Pos;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.MovieClip;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Lib;
import com.jumper.mutator.Scene;
import com.jumper.pools.VectorPool;
import haxe.Timer;


/**
 * @author Jonathan Dunlap
 */
class EpicGameJam extends Sprite {

	public static var keyInput:KeyboardInput;
    public static var touchInput:TouchInput;
	
	// fast allocator for vector2s, cleared once per frame
	static public var m_gTempVectorPool:VectorPool;
	
	static public var gameJam:EpicGameJam;
	
	static public var engine:Engine;
	
	var lastTimeStamp:Float;
	var currentTimeStamp:Float;
	
	public function new () {
		
		super ();
		
		initialize ();
	}
	
	private function initialize ():Void {
		
		gameJam = this;
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		keyInput = new KeyboardInput(Lib.current.stage);
        
        touchInput = new com.jumper.TouchInput(Lib.current.stage);
		
		m_gTempVectorPool = new VectorPool(1000);
		
		engine = new Engine();
		addChild(engine);
		
		trace("screen size: " + Lib.current.stage.stageWidth + ", " + Lib.current.stage.stageHeight);
		
		lastTimeStamp = Timer.stamp();
		addEventListener(Event.ENTER_FRAME, function(e):Void {
			currentTimeStamp = Timer.stamp();
			//trace(currentTimeStamp - lastTimeStamp);
			engine.update(currentTimeStamp - lastTimeStamp);
			lastTimeStamp = currentTimeStamp;
		});
	}
	
	
	// Entry point
	public static function main () {
		trace("main");
		Lib.current.addChild (new EpicGameJam ());
		
	}
	
	
}