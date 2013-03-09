package mutator;
import model.Movement;
import model.MoveNode;
import model.Pos;
import nme.errors.Error;
import nme.ui.Keyboard;
import nme.Lib;
import model.Collider;

/**
 * ...
 * @author Greg Back
 */

class PlayerMove implements ISystem
{
	//var models:Array<MoveNode>;
	var posList:Array<Pos>;
	var moveList:Array<Movement>;
	var colList:Array<Collider>;
	
	inline static var maxVel:Int = 50;
	
	public function new() 
	{
		//models = new Array<MoveNode>();
		
		moveList = new Array<Movement>();
		posList = new Array<Pos>();
		colList = new Array<Collider>();
	}
	public function add(entity:Entity):Void {
		posList.push(entity.fetch(Pos));
		moveList.push(entity.fetch(Movement));
		colList.push(entity.fetch(Collider));
	}
	public function update(time:Float):Void {
		var current:Int = 0;
		
		inline function movement():Void
		{
			var pos = posList[current];
			var movement = moveList[current];
			if (EpicGameJam.keyInput.getKeyDown(Keyboard.A))
			{
				movement.vel.x -= 5;
				if (movement.vel.x < -maxVel) movement.vel.x = -maxVel;
			}
			else if (EpicGameJam.keyInput.getKeyDown(Keyboard.D))
			{
				movement.vel.x += 5;
				if (movement.vel.x > maxVel) movement.vel.x = maxVel;
			}
			else
			{
				if (movement.vel.x > 0) {
					movement.vel.x -= 5;
					if (movement.vel.x < 0) movement.vel.x = 0;
				}
				if (movement.vel.x < 0) {
					movement.vel.x += 5;
					if (movement.vel.x > 0) movement.vel.x = 0;
				}
			}
			var jumping:Bool;
			var colliding:Bool;
			if (EpicGameJam.keyInput.getKeyDown(Keyboard.W))
				jumping = true;
			else
				jumping = false;
			if (pos.pt.y + 170 >= Lib.current.stage.stageHeight)
				colliding = true;
			else
				colliding = false;
				
			if (jumping && colliding)
				movement.vel.y -= 100;
			
			if (!colliding) {
				movement.vel.y += 10;
			}
			/*if (movement.vel.y < 0 && !colliding) {
				movement.vel.y += 20;
				trace("not colliding");
				//if (movement.vel.y > 0) movement.vel.y = 0;
			}
			if (movement.vel.y > 0 && !colliding) {
				movement.vel.y -= 20;
				if (movement.vel.y < 0) movement.vel.y = 0;
			}*/
			
			pos.pt.x += movement.vel.x;
			pos.pt.y += movement.vel.y;
			
			if (pos.pt.y + 170 > Lib.current.stage.stageHeight)
				pos.pt.y = Lib.current.stage.stageHeight - 170;
		}
		
		while (current < posList.length) {
			movement();
			current++;
		}
	}
}