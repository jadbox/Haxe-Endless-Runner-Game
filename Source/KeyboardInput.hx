package;
import nme.display.Sprite;
import nme.display.Stage;
import nme.events.KeyboardEvent;
import nme.ui.Keyboard;

/**
 * ...
 * @author Greg
 */

class KeyboardInput 
{
	var gameWorld:Stage;
	var keyStates:IntHash<Bool>;

	public function new(worldDisplay:Stage) 
	{
		gameWorld = worldDisplay;
		keyStates = new IntHash<Bool>();
		gameWorld.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		gameWorld.addEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
	
	function keyDown(keyDownEvent:KeyboardEvent):Void
	{
		keyStates.set(keyDownEvent.keyCode, true);
		trace("key down: " + keyDownEvent.keyCode);
	}
	
	function keyUp(keyUpEvent:KeyboardEvent):Void
	{
		keyStates.set(keyUpEvent.keyCode, false);
	}
	
	public function getKeyDown(keyCode:Int):Bool
	{
		if (keyStates.exists(keyCode) && keyStates.get(keyCode) == true) return true;
		return false;
	}
	
}