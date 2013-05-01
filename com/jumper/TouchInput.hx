package com.jumper;
import nme.display.Sprite;
import nme.display.Stage;
import nme.events.TouchEvent;
import com.jumper.maths.Vector2;
import nme.Vector;

import nme.events.MouseEvent;

/**
 * ...
 * @author Greg
 */

class TouchInput 
{
	var gameWorld:Stage;
	var touchStates:IntHash<Bool>;
	var lastKeyDown:Int;
    
    var debugDraw:Sprite;
    
    var lastPos:Vector2;
    
    var curAngle:Float = 0;
    
    var tapped:Bool = false;
    public var tapListeners:Array < Void->Void > ;
	
	public var swipeListeners:Array< String->Void >;

	public function new(worldDisplay:Stage) 
	{
		lastKeyDown = -1;
		gameWorld = worldDisplay;
		touchStates = new IntHash<Bool>();
        #if android
		gameWorld.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
		gameWorld.addEventListener(TouchEvent.TOUCH_END, touchEnd);
        gameWorld.addEventListener(TouchEvent.TOUCH_MOVE, touchMove);
        gameWorld.addEventListener(TouchEvent.TOUCH_TAP, touchTap);
        #else
        gameWorld.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
        gameWorld.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
        #end
        debugDraw = new Sprite();
        gameWorld.addChild(debugDraw);
        lastPos = new Vector2();
        
        tapListeners = new Array < Void->Void > ();
		swipeListeners = new Array < String->Void > ();
	}
	
	function touchBegin(touchBeginEvent:TouchEvent):Void
	{
		touchStates.set(touchBeginEvent.touchPointID, true);
		//trace("key down: " + keyDownEvent.keyCode);
	}
	
	function touchEnd(touchEndEvent:TouchEvent):Void
	{
		touchStates.set(touchEndEvent.touchPointID, false);
	}
    
    function touchMove(touchMoveEvent:TouchEvent):Void
    {
        //debugDraw.graphics.beginFill(0xff0000, 1);
        //debugDraw.graphics.drawCircle(touchMoveEvent.stageX, touchMoveEvent.stageY, 3);
        curAngle = lastPos.Sub(new Vector2(touchMoveEvent.stageX, touchMoveEvent.stageY)).ToAngle();
        lastPos.m_x = touchMoveEvent.stageX;
        lastPos.m_y = touchMoveEvent.stageY;
    }
    
    function touchTap(touchTapEvent:TouchEvent):Void
    {
        for (lstn in tapListeners) lstn();
    }
    
    public function getCurAngle():Float
    {
        return curAngle;
    }
    
    public function mouseDown(e:MouseEvent):Void
    {
        lastPos.m_x = e.stageX;
        lastPos.m_y = e.stageY;
        trace("mdown " + e.stageX + " , " + e.stageY);
    }
    
    public function mouseUp(e:MouseEvent):Void
    {
		var deltaX = e.stageX - lastPos.m_x;
		var deltaY = e.stageY - lastPos.m_y;
		var radRotation = Math.atan2(deltaY, deltaX);
		if (radRotation < 0) radRotation += Constants.kTwoPi;
		curAngle = radRotation;
        //curAngle = lastPos.Sub(new Vector2(e.stageX, e.stageY)).ToAngle();
        trace("mup " + e.stageX + " , " + e.stageY + " curAngle: " + curAngle);
		var absDeltaX = Math.abs(deltaX);
		var absDeltaY = Math.abs(deltaY);
        if (absDeltaX + absDeltaY < 40)
        {
            for (lstn in tapListeners) lstn();
        }else {
			for (lstn in swipeListeners) {
				if (absDeltaX > absDeltaY) {
					if (deltaX > 0) lstn("right");
					else lstn("left");
				}else {
					if (deltaY > 0) lstn("down");
					else lstn("up");
				}
			}
		}
		
    }
	
	public function getKeyDown(keyCode:Int):Bool
	{
		if (touchStates.exists(keyCode) && touchStates.get(keyCode) == true) return true;
		return false;
	}
	/*
	 * key is transitioning from up to down
	 */
	public function getKeyDownTransition(keyCode:Int):Bool
	{
		if (touchStates.exists(keyCode) && touchStates.get(keyCode) == true && lastKeyDown != keyCode) return true;
		return false;
	}
	
}