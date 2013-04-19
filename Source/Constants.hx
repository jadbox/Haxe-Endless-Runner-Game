package;

import maths.Vector2;

class Constants
{
	static public var kGravity:Float = 80;
	static public var kTwoPi:Float = Math.PI*2;
	static public var kMaxSpeed:Float = 200;
	static public var kScreenDimensions:Vector2 = new Vector2(640,360);
	static public var kWorldHalfExtents:Vector2;
	static public var kTileSize:Int = 64;
	static public var k24FpsTimeStep:Float = 1.0/24.0;
	static public var kDesiredFps:Float = 30.0;
	static public var kUnitYNeg:Vector2 = new Vector2(0,-1);
	static public var kExpand:Vector2 = new Vector2(5,5);
	static public var kPlaneHeight:Float = 12;
	static public var kPlayerWidth:Int = 40;
}

