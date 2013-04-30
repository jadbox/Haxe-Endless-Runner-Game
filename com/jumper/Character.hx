package com.jumper;

import maths.Vector2;

class Character extends MoveableObject
{
	// how many frames does tha player flash for?
	public var kEnemyHurtFrames:Int = 10;
	
	public var m_hurtTimer:Int;
	
	public function new( )
	{
		super( );
					
		m_hurtTimer = 0;
	}
	
	
	/// <summary>
	/// 
	/// </summary>	
	public function Hurt( hurtPos:Vector2 ):Void
	{
		throw "Not Implemented";
	}
	
	/// <summary>
	/// 
	/// </summary>
	public function getAnimSpeedMultiplier( ):Float
	{
		return 1.0;
	}
	
	/// <summary>
	/// 
	/// </summary>
	public function IsHurt( ):Bool
	{
		return m_hurtTimer!=0;
	}
}
