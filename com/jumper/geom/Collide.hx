package com.jumper.geom;


	import com.jumper.maths.Vector2;
	import com.jumper.level.TileTypes;
	import com.jumper.Constants;
	import com.jumper.level.Map;
	
	class Collide
	{
		/// <summary>
		/// Helper function which checks for internal edges
		/// </summary>	
		static private function IsInternalCollision( tileI:Int, tileJ:Int, normal:Vector2, map:Map ):Bool
		{
			var nextTileI:Int = Std.int(tileI+normal.m_x);
			var nextTileJ:Int = Std.int(tileJ+normal.m_y);
			
			var currentTile:Int = map.GetTile( tileI, tileJ );
			var nextTile:Int = map.GetTile( nextTileI, nextTileJ );
			
			var internalEdge:Bool = Map.IsTileObstacle(nextTile);
						
			return internalEdge;
		}
		
		/// <summary>
		/// Returns information about distance and direction from point to AABB
		/// </summary>
		static public function AabbVsAabbInternal( delta:Vector2, aabbCentre:Vector2, aabbHalfExtents:Vector2, point:Vector2, outContact:Contact ):Bool
		{
			// form the closest plane to the point
			var planeN:Vector2 = delta.m_MajorAxis.NegTo();
			var planeCentre:Vector2 = planeN.Mul( aabbHalfExtents ).AddTo(aabbCentre);
			
			// distance point from plane
			var planeDelta:Vector2 = point.Sub( planeCentre );
			var dist:Float = planeDelta.Dot( planeN );
			
			// form point
			
			
			// build and push
			outContact.Initialise( planeN, dist, point );
				
			// collision?
			return true;
		}
		
		/// <summary>
		/// 
		/// </summary>
		static public function AabbVsAabb( a:IAABB, b:IAABB, outContact:Contact, tileI:Int, tileJ:Int, map:Map, checkInternal:Bool=true ):Bool
		{
			//sees how close a gets to b, add radius of a to b
			var combinedExtentsB:Vector2 = EpicGameJam.m_gTempVectorPool.AllocateClone( b.getHalfExtents() ).AddTo(a.getHalfExtents());
			var combinedPosB:Vector2 = b.getCentre();
			
			var delta:Vector2 = combinedPosB.Sub(a.getCentre());
			
			AabbVsAabbInternal( delta, combinedPosB, combinedExtentsB, a.getCentre(), outContact );
			
			//
			// check for Internal edges
			//
			
			if ( checkInternal )
			{
				return !IsInternalCollision( tileI, tileJ, outContact.m_normal, map );
			}
			else 
			{
				return true;
			}
		}
		
		/// <summary>
		/// 
		/// </summary>
		static public function PointInAabb( point:Vector2, aabb:AABB ):Bool
		{
			var delta:Vector2 = point.Sub( aabb.getCentre() );
			
			return	Math.abs(delta.m_x) < aabb.getHalfExtents().m_x &&
					Math.abs(delta.m_y) < aabb.getHalfExtents().m_y;
		}
		
		/// <summary>
		/// Only collide with the top plane of Aabb b
		/// </summary>
		static public function AabbVsAabbTopPlane( a:IAABB, b:IAABB, outContact:Contact, tileI:Int, tileJ:Int, map:Map ):Bool
		{
			var collideAabb:Bool = AabbVsAabb( a, b, outContact, tileI, tileJ, map, false );
			if ( collideAabb )
			{
				// these conditions ensure that we only collide with the top plane, and that we have to be greater than 
				// -Constants.kPlaneHeight away from the surface for this collision to return true
				if ( outContact.m_normal.m_y<0&&outContact.m_dist>=-Constants.kPlaneHeight )
				{
					return true;
				}
			}
			
			return false;
		}
	}

