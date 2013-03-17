package system;
	
class Pool
{
	private var m_counter:Int;
	private var m_maxObjects:Int;
	private var m_pool:Array<Dynamic>;
	private var m_type:Class<Dynamic>;
	private var m_deallocateCalled:Bool;
	
	/// <summary>
	/// 
	/// </summary>	
	public function new( type:Class<Dynamic>, maxObjects:Int )
	{
		m_pool = [];
		
		// construct all objects
		var i:Int=0;
		while ( i < maxObjects )
		{
			m_pool[i] = Type.createInstance(type, []);
			i++;
		}
		
		m_counter=0;
		m_type=type;
		m_maxObjects=maxObjects;
		m_deallocateCalled = false;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function Allocate( args:Array<Dynamic> ):Dynamic
	{
		//Assert( m_counter<m_maxObjects, "Pool.GetObject(): pool out of space for type " + m_type );
		var obj:Dynamic;
		
		if ( m_counter<m_maxObjects )
		{
			obj = m_pool[m_counter++];
		}
		else 
		{
			obj = Type.createInstance(m_type, []);
		}
		
		if ( args.length==0 )
		{
			obj.Initialise( );
		}
		else if ( args.length==1 )
		{
			obj.Initialise( args[0] );
		}
		else if ( args.length==2 )
		{
			obj.Initialise( args[0], args[1] );
		}
		else if ( args.length==3 )
		{
			obj.Initialise( args[0], args[1], args[2] );
		}
		else if ( args.length==4 )
		{
			obj.Initialise( args[0], args[1], args[2], args[3] );
		}
		else if ( args.length==5 )
		{
			obj.Initialise( args[0], args[1], args[2], args[3], args[4] );
		}
		else if ( args.length==6 )
		{
			obj.Initialise( args[0], args[1], args[2], args[3], args[4], args[5] );
		}
		else if ( args.length==7 )
		{
			obj.Initialise( args[0], args[1], args[2], args[3], args[4], args[5], args[6] );
		}
		else 
		{
			throw "Unexpected Case";
		}
		
		return obj;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function Deallocate( obj:Dynamic ):Void
	{
		Util.Assert( Std.is(obj, m_type), "Pool.Deallocate(): object doesn't belong to this pool!" );
		Util.Assert( m_counter>0, "Pool.Deallocate(): too many deallocations!");
		m_pool[--m_counter] = obj;
		m_deallocateCalled = true;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public var m_Num(getNum, null):Int;
	function getNum():Int
	{
		return m_counter;
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function Get(i:Int):Dynamic
	{
		Util.Assert(i<m_counter, "Pool.Get(): index out of range!");
		return m_pool[i];
	}
	
	/// <summary>
	/// 
	/// </summary>	
	public function Clear():Void
	{
		Util.Assert( !m_deallocateCalled, "Pool.Clear(): Deallocate() already called! Clear cannot be used with this!" );
		m_counter=0;
	}
}
