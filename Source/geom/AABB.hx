package geom;

import maths.Vector2;
import maths.Scalar;

class AABB implements IAABB
{
	private var m_Centre:Vector2;
	public function getCentre():Vector2
	{
		return m_Centre;
	}
	private var m_HalfExtents(default, null):Vector2;
	public function getHalfExtents():Vector2
	{
		return m_HalfExtents;
	}

	/// <summary>
	/// 
	/// </summary>
	/// <param name="centre"></param>
	/// <param name="halfExtents"></param>
	public function new(centre:Vector2=null, halfExtents:Vector2=null)
	{
		Initialise( centre, halfExtents );	
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function Initialise(centre:Vector2, halfExtents:Vector2):Void
	{
		m_Centre = centre;
		m_HalfExtents = halfExtents;
		
		if ( m_HalfExtents!=null )
		{
			Util.Assert( m_HalfExtents.m_x>=0&&m_HalfExtents.m_y>=0, "AABB.Initialise(): cannot have negative half extents!" );
		}
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_BottomLeft(getBL, null):Vector2;
	function getBL():Vector2{
		return m_Centre.Add( new Vector2(-m_HalfExtents.m_x, m_HalfExtents.m_y) );	
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_BottomRight(getBR, null):Vector2;
	function getBR():Vector2{
		return m_Centre.Add( new Vector2(m_HalfExtents.m_x, m_HalfExtents.m_y) );	
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_TopLeft(getTL, null):Vector2;
	function getTL():Vector2{
		return m_Centre.Add( new Vector2(-m_HalfExtents.m_x, -m_HalfExtents.m_y) );	
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_TopRight(getTR, null):Vector2;
	function getTR():Vector2{
		return m_Centre.Add( new Vector2(m_HalfExtents.m_x, -m_HalfExtents.m_y) );	
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_Min(getTL, null):Vector2;
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_Max(getTR, null):Vector2;
	
	/// <summary>
	/// 
	/// </summary>	
	public function MinInto( v:Vector2 ):Vector2
	{
		v.CloneInto( m_Centre );
		v.SubFrom( m_HalfExtents );
		
		return v;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function Enlarge( amount:Float ):Void
	{
		m_HalfExtents.m_x += amount;
		m_HalfExtents.m_y += amount;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function EnlargeY( amount:Float ):Void
	{
		m_HalfExtents.m_y += amount;
	}

	/// <summary>
	/// 
	/// </summary>
	/// <param name="a"></param>
	/// <param name="b"></param>
	/// <returns></returns>
	static public function Overlap(a:IAABB, b:IAABB):Bool
	{
		//var d:Vector2 = b.m_Centre.Sub(a.m_Centre).m_Abs.Sub(a.m_HalfExtents.Add(b.m_HalfExtents));
		//return d.m_x < 0 && d.m_y < 0;
		
		var centreDelta:Vector2 = new Vector2();//Platformer.m_gTempVectorPool.Allocate();
		centreDelta.CloneInto( b.getCentre() );
		centreDelta.SubFrom( a.getCentre() );
		centreDelta.AbsTo( );
		
		var halfExtentsSum:Vector2 = new Vector2();//Platformer.m_gTempVectorPool.Allocate();
		halfExtentsSum.CloneInto( a.getHalfExtents() );
		halfExtentsSum.AddTo( b.getHalfExtents() );
		
		centreDelta.SubFrom( halfExtentsSum );
		
		return centreDelta.m_x < 0 && centreDelta.m_y < 0;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function Within( p:Vector2 ):Bool
	{
		var d:Vector2 = p.Sub( m_Centre ).m_Abs;
		return d.m_x<m_HalfExtents.m_x&&d.m_y<m_HalfExtents.m_y;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function GetRandomPointWithin( scaleX:Float=1, scaleY:Float=1 ):Vector2
	{
		var point:Vector2 = new Vector2( );
		point.CloneInto( m_Centre );
		point.m_x += Scalar.RandBetween( -m_HalfExtents.m_x, m_HalfExtents.m_x )*scaleX;
		point.m_y += Scalar.RandBetween( -m_HalfExtents.m_y, m_HalfExtents.m_y )*scaleY;
		return point;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function ClampInto(candidate:Vector2):Vector2
	{
		return candidate.SubFrom(m_Centre).ClampInto(m_Max, m_Min).AddTo(m_Centre);
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function UpdateFrom( centre:Vector2, halfExtents:Vector2 ):Void
	{
		m_Centre = centre;
		m_HalfExtents = halfExtents;
	}
}

