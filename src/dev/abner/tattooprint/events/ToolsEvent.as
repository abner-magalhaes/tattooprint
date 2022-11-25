package dev.abner.tattooprint.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Abner de Oliveira Magalhães
	 */
	public class ToolsEvent extends Event 
	{
		
		public static const ADD_IMAGE:String = "addImage";
		public static const CHANGE_ORIENTATION:String = "changeOrientation";
		public static const PRINT:String = "print";
		
		public function ToolsEvent(type:String) { 
			super(type, false, false);
		} 
		
		public override function clone():Event { 
			return new ToolsEvent(type);
		} 
		
		public override function toString():String { 
			return formatToString("ToolsEvent", "type"); 
		}
		
	}
	
}