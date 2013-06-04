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
		if (velocity.m_y < 1) {
			curSpriteAnim.animName = "jump_rise";
		}else {
			curSpriteAnim.animName = "walk";
		}
	}
	
}