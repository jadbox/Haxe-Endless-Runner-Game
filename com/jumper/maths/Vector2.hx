package com.jumper.maths;

	import nme.geom.Point;
	import Constants;
	
	/**
	 * ...
	 * @author wildbunny
	 * @port by gback
	 */
	class Vector2
	{
		public var m_x:Float;
		public var m_y:Float;
		
		/// <summary>
		/// 
		/// </summary>	
		public function new( x:Float = 0, y:Float = 0)
		{
			Initialise( x, y );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Initialise( x:Float=0, y:Float=0 ):Void
		{
			m_x = x;
			m_y = y;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Add( v : Vector2 ) : Vector2
		{
			return new Vector2(m_x + v.m_x, m_y + v.m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddTo( v:Vector2 ):Vector2
		{
			m_x += v.m_x;
			m_y += v.m_y;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubFrom( v:Vector2 ):Vector2
		{
			m_x -= v.m_x;
			m_y -= v.m_y;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubScalar( s:Float ):Vector2
		{
			return new Vector2( m_x-s, m_y-s );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddScalar( s:Float ):Vector2
		{
			return new Vector2( m_x+s, m_y+s );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubScalarFrom( s:Float ):Vector2
		{
			m_x -= s;
			m_y -= s;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddScalarTo( s:Float ):Vector2
		{
			m_x += s;
			m_y += s;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddX( x : Float ) : Vector2
		{
			return new Vector2(m_x + x, m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddY( y : Float ) : Vector2
		{
			return new Vector2(m_x, m_y+y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubX( x:Float ) : Vector2
		{
			return new Vector2(m_x-x, m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubY( y:Float ) : Vector2
		{
			return new Vector2(m_x, m_y-y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddXTo( x : Float ) : Vector2
		{
			m_x += x;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AddYTo( y : Float ) : Vector2
		{
			m_y += y;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubXFrom( x:Float ) : Vector2
		{
			m_x -= x;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function SubYFrom( y:Float ) : Vector2
		{
			m_y -= y;
			return this;
		}
		
		
		/// <summary>
		/// 
		/// </summary>	
		public function Sub( v : Vector2 ) : Vector2
		{
			return new Vector2(m_x - v.m_x, m_y - v.m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Mul( v : Vector2 ) : Vector2
		{
			return new Vector2(m_x * v.m_x, m_y * v.m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>
		public function MulTo( v:Vector2 ):Vector2
		{
			m_x *= v.m_x;
			m_y *= v.m_y;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Div( v : Vector2 ) : Vector2
		{
			return new Vector2(m_x / v.m_x, m_y / v.m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function MulScalar( s : Float ) : Vector2
		{
			return new Vector2(m_x * s, m_y * s);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function MulScalarTo( s : Float ) : Vector2
		{
			m_x *= s;
			m_y *= s;
			
			return this;
		}
		
		/// <summary>
		/// Multiples v by s and then adds to the current vector
		/// </summary>	
		public function MulAddScalarTo( v:Vector2, s:Float ):Vector2
		{
			m_x += v.m_x*s;
			m_y += v.m_y*s;
			
			return this;
		}
		
		/// <summary>
		/// Multiples v by s and then subtracts from the current vector
		/// </summary>	
		public function MulSubScalarTo( v:Vector2, s:Float ):Vector2
		{
			m_x -= v.m_x*s;
			m_y -= v.m_y*s;
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Dot( v : Vector2 ) : Float
		{
			return m_x * v.m_x + m_y * v.m_y;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public var m_LenSqr(getLenSqr, null) : Float;
		function getLenSqr():Float
		{
			return Dot(this);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public var m_Len(getLen, null) : Float;
		function getLen():Float
		{
			return Math.sqrt( m_LenSqr );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public var m_Abs(getAbs, null) : Vector2;
		function getAbs():Vector2
		{
			return new Vector2( Math.abs( m_x ), Math.abs( m_y ) );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public var m_Unit(getUnit, null) : Vector2;
		function getUnit():Vector2
		{
			var invLen : Float = 1.0 / m_Len;
			return MulScalar(invLen);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public var m_Floor(getFloor, null):Vector2;
		function getFloor():Vector2
		{
			return new Vector2(Math.floor(m_x), Math.floor(m_y));
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Clamp(min : Vector2, max : Vector2):Vector2
		{
			return new 	Vector2
						(
							Math.max( Math.min(m_x, max.m_x), min.m_x ),
							Math.max( Math.min(m_y, max.m_y), min.m_y )
						);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function ClampInto( min:Vector2, max:Vector2 ):Vector2
		{
			m_x = Math.max( Math.min( m_x, max.m_x ), min.m_x );
			m_y = Math.max( Math.min( m_y, max.m_y ), min.m_y );
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public var m_Perp(getPerp, null):Vector2;
		function getPerp():Vector2
		{
			return new Vector2( -m_y, m_x);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public var m_Neg(getNeg, null):Vector2;
		function getNeg():Vector2
		{
			return new Vector2( -m_x, -m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function NegTo( ):Vector2
		{
			m_x = -m_x;
			m_y = -m_y;
			
			return this;
		}
	
		/// <summary>
		/// 
		/// </summary>	
		public function Equal(v:Vector2):Bool
		{
			return m_x == v.m_x && m_y == v.m_y;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public static function FromAngle(angle:Float) : Vector2
		{
			return new Vector2(Math.cos(angle), Math.sin(angle));
		}

		/// <summary>
		/// 
		/// </summary>	
		public function ToAngle() : Float
		{
			var angle:Float = Math.atan2(m_y, m_x);

			// make the returned range 0 -> 2*PI
			if (angle < 0.0)
			{
				angle += Constants.kTwoPi;
			}
			return angle;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public static function RandomRadius(r:Float):Vector2
		{
			return new 	Vector2
						(
							Math.random() * 2 - 1,
							Math.random() * 2 - 1
						).MulScalar( r );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public static function FromPoint( point:Point ):Vector2
		{
			return new Vector2(point.x,point.y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public var m_Point(getPoint, null):Point;
		function getPoint():Point
		{
			return new Point(m_x, m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Clear( ):Void
		{
			m_x=0;
			m_y=0;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Clone( ):Vector2
		{
			return new Vector2(m_x, m_y);
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function toString( ):String
		{
			return "x="+m_x+",y="+m_y;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function CloneInto( v:Vector2 ):Vector2
		{
			m_x = v.m_x;
			m_y = v.m_y;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function MaxInto( b:Vector2 ):Vector2
		{
			m_x = Math.max( m_x, b.m_x );
			m_y = Math.max( m_y, b.m_y );
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function MinInto( b:Vector2 ):Vector2
		{
			m_x = Math.min( m_x, b.m_x );
			m_y = Math.min( m_y, b.m_y );
			
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Min( b:Vector2 ):Vector2
		{
			return new Vector2( m_x, m_y ).MinInto( b );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function Max( b:Vector2 ):Vector2
		{
			return new Vector2( m_x, m_y ).MaxInto( b );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function AbsTo():Void
		{
			m_x = Math.abs( m_x );
			m_y = Math.abs( m_y );
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function UnitTo() : Vector2
		{
			var invLen : Float = 1.0 / m_Len;
			m_x *= invLen;
			m_y *= invLen;
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>	
		public function IsNaN( ):Bool
		{
			return !Std.is(m_x, Float)||!Std.is(m_y, Float);
		}
		
		/// <summary>
		/// Get the largest coordinate and return a signed, unit vector containing only that coordinate
		/// </summary>	
		public var m_MajorAxis(getMajorAxis,null):Vector2;
		function getMajorAxis():Vector2
		{
			if ( Math.abs( m_x )>Math.abs( m_y ) )
			{
				return new Vector2( Scalar.Sign(m_x), 0 );
			}
			else 
			{
				return new Vector2( 0, Scalar.Sign(m_y) );
			}
		}
		
		/// <summary>
		/// 
		/// </summary>
		public function FloorTo( ):Vector2
		{
			m_x = Math.floor( m_x );
			m_y = Math.floor( m_y );
			return this;
		}
		
		/// <summary>
		/// 
		/// </summary>
		public function RoundTo( ):Vector2
		{
			m_x = Math.floor( m_x+0.5 );
			m_y = Math.floor( m_y+0.5 );
			return this;
		}
	}
