package maths;

import nme.geom.ColorTransform;
import nme.utils.Endian;

class Scalar
{
	static public var kMaxRandValue:UInt = 65535;
	
	/// <summary>
	/// Return only the fractional component of n - always positive
	/// </summary>
	/// <param name="n"></param>
	/// <returns></returns>
	static public function Frac( n:Float ):Float
	{
		var abs:Float=Math.abs( n );
		return abs-Math.floor( abs );
	}
	
	/// <summary>
	/// x = 1.5, range = 1
	/// t = 1.5 / 1 = 1.5
	/// ft = 0.5
	/// return = 1*0.5 = 0.5 
	/// </summary>
	/// <param name="x"></param>
	/// <param name="range"></param>
	/// <returns></returns>
	static public function Wrap(x:Float, range:Float):Float
	{
		var t:Float = x / range;
		var ft:Float = Frac(t);
		return range * ft;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function EaseOut( x:Float ):Float
	{
		var a:Float=x-1;
		return a*a*a + 1;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function EaseOutVel( x:Float ):Float
	{
		var a:Float=x-1;
		return a*a*3;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function RandBetween( a:Float, b:Float ):Float
	{
		return Math.random( )*( b-a )+a;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function RandBetweenInt( a:Int, b:Int ):Int
	{
		return Std.int(RandBetween( a, b ));
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function RandUint( ):Int
	{
		return Std.int(Math.abs((Math.random( )*kMaxRandValue)));
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function RandInt( ):Int
	{
		return Std.int(Math.random( )*kMaxRandValue);
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function FromVector2( v:Vector2):Float
	{
		return Math.atan2( v.m_y, v.m_x );
	}
	
	/// <summary>
	/// 0xrrggbb
	/// </summary>	
	static public function MakeColour(r:UInt,g:UInt,b:UInt):UInt
	{
		return r|( g<<8 )|( b<<16 );
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function RedFromColour( c:UInt ):UInt
	{
		return c&0xff;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function GreenFromColour( c:UInt ):UInt
	{
		return (c>>8)&0xff;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function BlueFromColour( c:UInt ):UInt
	{
		return (c>>16)&0xff;
	}
	
	/// <summary>
	/// maps 0-infinity to 0-1
	/// </summary>	
	static public function InfinityCurve(x:Float):Float
	{
		return -1/(x+1) + 1;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function ColorTransformFromBGR( bgr:UInt ):ColorTransform
	{
		return new ColorTransform( Scalar.BlueFromColour( bgr )/255.0, Scalar.GreenFromColour( bgr )/255.0, Scalar.RedFromColour( bgr )/255.0 );
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function ColorTransformFromRGB( rgb:UInt ):ColorTransform
	{
		return new ColorTransform( Scalar.RedFromColour( rgb )/255.0, Scalar.GreenFromColour( rgb )/255.0, Scalar.BlueFromColour( rgb )/255.0 );
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function RadToDeg( radians:Float ):Float
	{
		return ( radians/Math.PI )*180;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	static public function Clamp( a:Float, min:Float, max:Float ):Float
	{
		a = Math.max( min, a );
		a = Math.min( max, a );
		return a;
	}
	
	/// <summary>
	/// 
	/// </summary>
	static public function Sign( a:Float ):Float
	{
		return a>=0 ? 1 : -1;
	}
}
