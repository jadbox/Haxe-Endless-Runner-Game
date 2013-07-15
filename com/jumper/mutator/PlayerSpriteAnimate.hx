package com.jumper.mutator;
import com.jumper.maths.Vector2;
import nme.display.Sprite;

/**
 * ...
 * @author gback
 */

class PlayerSpriteAnimate extends SpriteAnimate
{

	public function new(root:Sprite) 
	{
		super(root);
	}
	
	override private function setAnimations():Dynamic 
	{
		var velocity:Vector2 = curPos.vel;
		//trace("onground: " + curPos.onGround + " ongroundlast: " + curPos.onGroundLast);
		//trace("Velocity x: " + velocity.m_x + " y: " + velocity.m_y);
		
		if (curPos.onGround) {
			curSpriteAnim.animName = "walk";
		}else {
			if (velocity.m_y <  -50)
				curSpriteAnim.animName = "jump_rise";
			else if (velocity.m_y >= -50 && velocity.m_y <= 100)
				curSpriteAnim.animName = "jump_peak";
			else
				curSpriteAnim.animName = "jump_fall";
				
		}
		
		/*if (velocity.m_y < 0) {
			curSpriteAnim.animName = "jump_rise";
		}else {
			if (curPos.onGround) {
				curSpriteAnim.animName = "walk";
			}else if (velocity.m_y < 100) {
				curSpriteAnim.animName = "jump_peak";
			}else {
				curSpriteAnim.animName = "jump_fall";
			}
			
		}*/
	}
	
}