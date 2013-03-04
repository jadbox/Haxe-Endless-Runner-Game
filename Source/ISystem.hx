package ;

/**
 * ...
 * @author Jonathan Dunlap
 */

interface ISystem 
{

	function update(time:Float):Void;
	function start():Void;
	function stop():Void;
	function add(e:Entity):Void;
}