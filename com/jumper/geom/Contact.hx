package com.jumper.geom;

	import com.jumper.maths.Vector2;
	
	/*public class Contact
	{
		/// <summary>
		/// 
		/// </summary>	
		public function Initialise( i:int, j:int, pos:Vector2, tile:int, collision:Boolean ):void
		{
			m_i = i;
			m_j = j;
			m_pos = pos;
			m_tile = tile;
			m_collision = collision;
		}
		public var m_i:int;
		public var m_j:int;
		public var m_pos:Vector2;
		public var m_tile:int;
		public var m_collision:Boolean;
	}*/
	
	class Contact
	{
		
		public function new(){}
		/// <summary>
		/// 
		/// </summary>	
		public function Initialise( n:Vector2, dist:Float, p:Vector2 ):Void
		{
			m_normal = n;
			m_dist = dist;
			m_impulse = 0;
			m_p = p;
		}
		public var m_normal:Vector2;
		public var m_dist:Float;
		public var m_impulse:Float;
		public var m_p:Vector2;
	}

