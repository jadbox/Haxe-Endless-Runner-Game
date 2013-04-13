package pools;

import maths.Vector2;

class VectorPool extends Pool
{
	public function new( maxObjects:Int=0 )
	{
		super( Vector2, maxObjects );
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function AllocateClone( v:Vector2 ):Vector2
	{
		
		return Allocate( [v.m_x, v.m_y] ); 
	}
}

