package mutator;

/**
 * ...
 * @author gback
 */
import nme.display.MovieClip;
import nme.display.Sprite;
import nme.geom.Matrix;
import maths.Vector2;
import geom.AABB;
import geom.IAABB;
import model.Pos;

class Camera 
{
	static public var kInitialZoom:Float = 1;
	static private var kMinScale:Float = 1;
	static private var kMaxScale:Float = 1;
	
	private var m_parent:Sprite;
	private var m_character:Entity;
	private var m_scale:Vector2;
	private var m_translate:Vector2;
	private var m_worldToScreen:Matrix;
	private var m_screenToWorld:Matrix;
	
	private var m_screenSpaceAABB:AABB;
	private var m_cameraPos:Vector2;

	public function new(parent:Sprite, character:Entity) 
	{
		m_parent = parent;
		//character must have Pos
		m_character = character;
		Util.Assert(null == character.fetch(Pos), "Character does not have position model");
		m_scale = new Vector2(kInitialZoom, kInitialZoom);
		var screenCentre:Vector2 = new Vector2(Constants.kScreenDimensions.m_x / 2, Constants.kScreenDimensions.m_y / 2);
		m_screenSpaceAABB = new AABB(screenCentre, screenCentre);
		m_cameraPos = character.fetch(Pos).vec.Clone();
	}
	
}