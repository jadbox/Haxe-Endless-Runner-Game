package ;

/**
 * ...
 * @author gback
 */

class Util 
{

	public static function Assert(expr:Bool, message:String):Void
	{
		if (!expr)
			throw message;
	}
	
}